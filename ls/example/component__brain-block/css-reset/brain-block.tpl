
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

