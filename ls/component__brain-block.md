# LiveStreet 2.0
### Статично динамичный компонент. Умный блок с текстом\html

Приведу пример с использованием статичных данных.

Хочу я на своем сайте текстовый блок на некоторых страницах. Например с правилами раздела.
Для каждой страницы блок может иметь свою структуру, свое содержание.
Допустим я не умею программировать.
Но при минимальных знаниях html + smarty и компонентам LS можно сделать следующее.

Буду расширять компонент css-reset, первый попался под руку. Можно написать и новый, но его нужно регистрировать.
А расширив, я смогу просто закинуть папку в шаблон и всё будет работать (при условии что компонент css-reset загружается даным шаблоном).


Создаю папку с названием *css-reset*, в нем файл *brain-block.tpl* с таким содержанием:

```smarty
{component_define_params params=[ 'mods', 'classes', 'attributes' ]}
    {* Определяем текущий экшн и эвент *}

    {$action = Router::GetAction()}
    {$event = Router::GetActionEvent()}

    {* Формируем название шаблона экшна *}
    {$templateActionName = "action{$action|ucfirst}"}

    {* Формируем название шаблона эвента *}
    {$templateEventName = "event{$event|ucfirst}"}
    {$templateEvent = $LS->Component_GetTemplatePath('css-reset', "{$templateActionName}.{$templateEventName}")}

    {* Если существует шаблон эвента, выводим *}
    {if $templateEvent}
       {component "css-reset" template="{$templateActionName}.{$templateEventName}" action=$action event=$event params=$params}

    {* Иначе выводим шаблон экшна *}
    {else}
       {$templateAction = $LS->Component_GetTemplatePath('css-reset', $templateActionName)}
       {if $templateAction}
          {component "css-reset" template="{$templateActionName}" action=$action params=$params}
       {/if}
    {/if}
```

Открываю файл **/шаблон/layouts/layout.base.tpl**, вставляю куда хочу вызов компонента
```smarty
    {component 'css-reset.brain-block'}
```
Захотел перед заголовком страницы.


Можно вызывать автономно, например через хук. Который так же например лежит в плагине.

```smarty
    $this->Viewer_Fetch('component@css-reset.brain-block');
```

В нашем примере вешать будем на хук **template_layout_content_header_begin**


Подключили. Заходим на сайт, смотрим что ошибок нет. Не изменилось собственно ничего.


Теперь я создам базовый файлик своего "текстового блока". Назову его **this-is-basic.tpl**, содержание такое:


```smarty
    {$it_is_component = 'chiffa-page-brain-block'}

    {component_define_params params=[ 'action', 'event', 'title', 'text', 'mods', 'classes', 'attributes' ]}

    {block 'chiffa_write_options_here'}
       {$my_custom_delimiter = '__'}

       {if $action}
          {$mods = "{$mods} action-{$action}"}
       {/if}

       {if $event}
          {$mods = "{$mods} event-{$event}"}
       {/if}
    {/block}


    {block 'chiffa_write_content_here'}
       <div class="{$it_is_component} {cmods name=$it_is_component mods=$mods delimiter=$my_custom_delimiter} {$classes}"
          {cattr list=$attributes}>

          <div class="{$it_is_component}-wrapper">
             {block 'chiffa_write_wrapper_here'}
                {block 'chiffa_write_header_here' hide}
                   <div class="{$it_is_component}-header">
                      {$smarty.block.child}
                   </div>
                {/block}

                {block 'chiffa_write_body_here'}
                   <div class="{$it_is_component}-body">
                      {$smarty.block.child}
                   </div>
                {/block}
             {/block}
          </div>
       </div>
    {/block}
```

Что тут к чем, можно почитать в документации по Smarty и в руководстве по созданию компонентов от @deniart.

Впрочем, если будет интересно, распишу.


Готово!


А теперь то, ради чего всё это делалось.


Добавим как мы блок на страницу blog (сайт.нет/blog/).

Для этого мы создаем файл, который имеет имя **actionBlog.tpl**

Пишу в него что-то типо этого:

```smarty
    {extends 'component@css-reset.this-is-basic'}

    {block 'chiffa_write_header_here'}
       {component 'icon' icon='folder'}
       Блоги - это такие удобные общие папки для хранения статей
    {/block}

    {block 'chiffa_write_body_here'}
       Правила раздела гласят, что всякую фигню постить нужно у себя Вконтакте а не здесь!
    {/block}
```

Перехожу на эту страницу на сайте и наблюдаю результат (скриншот).

Недостаток моего кода (**brain-block.tpl**), что этот блок выводится так же на всех внутренних страницах - `/blog/new` `/blog/dog` `/blog/kot` и т.д. - но мне честно лень его идеализировать.


Зато, создав файл **actionBlog.eventDiscussed.tpl**

```smarty
    {extends 'component@css-reset.this-is-basic'}

    {block 'chiffa_write_header_here'}
       {component 'icon' icon='folder'}

       Тише! Идет дисскусия
    {/block}

    {block 'chiffa_write_body_here'}
       За комментарии с орфографическими ошибками, невыспавшийся администратор раздает баны!
    {/block}
```

и перейдя на страницу "обсуждаемые" я увижу такое (https://yadi.sk/i/XuvSmV053FKsfg)


Может кто-то (а до здесь кто-то дочитал? как тебя зовут, друг?) заметил что блок имеет немного другое оформление, хотя в 2х файлах выше я явно не описывал каких-либо "режимов отображения" и т.п.


Тут работает код базового шаблона

```smarty
    {if $action}
       {$mods = "{$mods} action-{$action}"}
    {/if}
    {if $event}
       {$mods = "{$mods} event-{$event}"}
    {/if}
```

Которого мне на данном этапе абсолютно достаточно для кастомизации.

Ниже будет ссылка на архив с файлами, там можно посмотреть css.


Попробуем сильней кастомизировать наш блок. Выведем его на страницу "люди.

Создаю файл **actionPeople.tpl**:

```smarty
    {extends 'component@css-reset.this-is-basic'}

    {block 'chiffa_write_header_here'}
       {component 'icon' icon='child'}
       Люди, внемлите!
    {/block}

    {block 'chiffa_write_wrapper_here' append}
       <div class="{$it_is_component}-footer">
          Добавлю футер, почему нет?
       </div>
    {/block}

    {block 'chiffa_write_body_here'}
       <div class="ls-grid-row">
          <div class="ls-grid-col ls-grid-col-3">Инфа</div>
          <div class="ls-grid-col ls-grid-col-3">представлена</div>
          <div class="ls-grid-col ls-grid-col-3">в четыре</div>
          <div class="ls-grid-col ls-grid-col-3">колонки</div>
       </div>
    {/block}
```

https://yadi.sk/i/esdUABUj3FKuzT

*Продолжение следует...*
