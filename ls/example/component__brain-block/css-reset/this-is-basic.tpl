
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

