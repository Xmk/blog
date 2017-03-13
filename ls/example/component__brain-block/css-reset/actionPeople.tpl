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


