# CSS - Tailwind CSS - Complete Utility Classes Reference

## Table of Contents
1. [Layout](#layout)
2. [Flexbox & Grid](#flexbox--grid)
3. [Spacing](#spacing)
4. [Sizing](#sizing)
5. [Typography](#typography)
6. [Backgrounds](#backgrounds)
7. [Borders](#borders)
8. [Effects](#effects)
9. [Filters](#filters)
10. [Tables](#tables)
11. [Transitions & Animation](#transitions--animation)
12. [Transforms](#transforms)
13. [Interactivity](#interactivity)
14. [SVG](#svg)
15. [Accessibility](#accessibility)

---

## Layout

### Aspect Ratio
- `aspect-auto` - Aspect ratio auto
- `aspect-square` - Aspect ratio 1/1
- `aspect-video` - Aspect ratio 16/9

### Container
- `container` - Set max-width to breakpoint

### Columns
- `columns-1` through `columns-12` - Set number of columns
- `columns-auto` - Columns auto
- `columns-3xs` through `columns-7xl` - Column widths

### Break After
- `break-after-auto`, `break-after-avoid`, `break-after-all`
- `break-after-avoid-page`, `break-after-page`
- `break-after-left`, `break-after-right`, `break-after-column`

### Break Before
- `break-before-auto`, `break-before-avoid`, `break-before-all`
- `break-before-avoid-page`, `break-before-page`
- `break-before-left`, `break-before-right`, `break-before-column`

### Break Inside
- `break-inside-auto`, `break-inside-avoid`
- `break-inside-avoid-page`, `break-inside-avoid-column`

### Box Decoration Break
- `box-decoration-clone` - Clone box decoration
- `box-decoration-slice` - Slice box decoration

### Box Sizing
- `box-border` - Border box
- `box-content` - Content box

### Display
- `block` - Display block
- `inline-block` - Display inline-block
- `inline` - Display inline
- `flex` - Display flex
- `inline-flex` - Display inline-flex
- `table` - Display table
- `inline-table` - Display inline-table
- `table-caption` - Display table-caption
- `table-cell` - Display table-cell
- `table-column` - Display table-column
- `table-column-group` - Display table-column-group
- `table-footer-group` - Display table-footer-group
- `table-header-group` - Display table-header-group
- `table-row-group` - Display table-row-group
- `table-row` - Display table-row
- `flow-root` - Display flow-root
- `grid` - Display grid
- `inline-grid` - Display inline-grid
- `contents` - Display contents
- `list-item` - Display list-item
- `hidden` - Display none

### Floats
- `float-start` - Float inline-start
- `float-end` - Float inline-end
- `float-right` - Float right
- `float-left` - Float left
- `float-none` - Float none

### Clear
- `clear-start` - Clear inline-start
- `clear-end` - Clear inline-end
- `clear-left` - Clear left
- `clear-right` - Clear right
- `clear-both` - Clear both
- `clear-none` - Clear none

### Isolation
- `isolate` - Create stacking context
- `isolation-auto` - Isolation auto

### Object Fit
- `object-contain` - Object fit contain
- `object-cover` - Object fit cover
- `object-fill` - Object fit fill
- `object-none` - Object fit none
- `object-scale-down` - Object fit scale-down

### Object Position
- `object-bottom`, `object-center`, `object-left`
- `object-left-bottom`, `object-left-top`
- `object-right`, `object-right-bottom`, `object-right-top`
- `object-top`

### Overflow
- `overflow-auto`, `overflow-hidden`, `overflow-clip`
- `overflow-visible`, `overflow-scroll`
- `overflow-x-auto`, `overflow-x-hidden`, `overflow-x-clip`
- `overflow-x-visible`, `overflow-x-scroll`
- `overflow-y-auto`, `overflow-y-hidden`, `overflow-y-clip`
- `overflow-y-visible`, `overflow-y-scroll`

### Overscroll Behavior
- `overscroll-auto`, `overscroll-contain`, `overscroll-none`
- `overscroll-x-auto`, `overscroll-x-contain`, `overscroll-x-none`
- `overscroll-y-auto`, `overscroll-y-contain`, `overscroll-y-none`

### Position
- `static` - Position static
- `fixed` - Position fixed
- `absolute` - Position absolute
- `relative` - Position relative
- `sticky` - Position sticky

### Top / Right / Bottom / Left
- `inset-0` through `inset-96` - All sides
- `inset-auto`, `inset-1/2`, `inset-1/3`, `inset-2/3`, `inset-1/4`, `inset-2/4`, `inset-3/4`
- `inset-full` - 100%
- `inset-x-{value}` - Horizontal
- `inset-y-{value}` - Vertical
- `start-{value}`, `end-{value}` - Inline start/end
- `top-{value}`, `right-{value}`, `bottom-{value}`, `left-{value}` - Individual sides
- Negative values: `-inset-{value}`, `-top-{value}`, etc.

### Visibility
- `visible` - Visibility visible
- `invisible` - Visibility hidden
- `collapse` - Visibility collapse

### Z-Index
- `z-0`, `z-10`, `z-20`, `z-30`, `z-40`, `z-50`
- `z-auto` - Z-index auto
- `-z-{value}` - Negative z-index

---

## Flexbox & Grid

### Flex Basis
- `basis-0` through `basis-96` - Fixed basis
- `basis-auto`, `basis-full`
- `basis-1/2`, `basis-1/3`, `basis-2/3`, `basis-1/4`, `basis-2/4`, `basis-3/4`
- `basis-1/5`, `basis-2/5`, `basis-3/5`, `basis-4/5`
- `basis-1/6`, `basis-2/6`, `basis-3/6`, `basis-4/6`, `basis-5/6`
- `basis-1/12`, `basis-2/12`, ... `basis-11/12`

### Flex Direction
- `flex-row` - Flex direction row
- `flex-row-reverse` - Flex direction row-reverse
- `flex-col` - Flex direction column
- `flex-col-reverse` - Flex direction column-reverse

### Flex Wrap
- `flex-wrap` - Flex wrap
- `flex-wrap-reverse` - Flex wrap-reverse
- `flex-nowrap` - Flex nowrap

### Flex
- `flex-1` - Flex 1 1 0%
- `flex-auto` - Flex 1 1 auto
- `flex-initial` - Flex 0 1 auto
- `flex-none` - Flex none

### Flex Grow
- `grow` - Flex grow 1
- `grow-0` - Flex grow 0

### Flex Shrink
- `shrink` - Flex shrink 1
- `shrink-0` - Flex shrink 0

### Order
- `order-1` through `order-12` - Flex/grid order
- `order-first` - Order -9999
- `order-last` - Order 9999
- `order-none` - Order 0

### Grid Template Columns
- `grid-cols-1` through `grid-cols-12` - Grid columns
- `grid-cols-none` - No grid columns
- `grid-cols-subgrid` - Subgrid

### Grid Column Start / End
- `col-auto` - Grid column auto
- `col-span-1` through `col-span-12` - Span columns
- `col-span-full` - Span all columns
- `col-start-1` through `col-start-13` - Column start
- `col-start-auto` - Column start auto
- `col-end-1` through `col-end-13` - Column end
- `col-end-auto` - Column end auto

### Grid Template Rows
- `grid-rows-1` through `grid-rows-12` - Grid rows
- `grid-rows-none` - No grid rows
- `grid-rows-subgrid` - Subgrid

### Grid Row Start / End
- `row-auto` - Grid row auto
- `row-span-1` through `row-span-12` - Span rows
- `row-span-full` - Span all rows
- `row-start-1` through `row-start-13` - Row start
- `row-start-auto` - Row start auto
- `row-end-1` through `row-end-13` - Row end
- `row-end-auto` - Row end auto

### Grid Auto Flow
- `grid-flow-row` - Grid auto flow row
- `grid-flow-col` - Grid auto flow column
- `grid-flow-dense` - Grid auto flow dense
- `grid-flow-row-dense` - Grid auto flow row dense
- `grid-flow-col-dense` - Grid auto flow column dense

### Grid Auto Columns
- `auto-cols-auto`, `auto-cols-min`, `auto-cols-max`, `auto-cols-fr`

### Grid Auto Rows
- `auto-rows-auto`, `auto-rows-min`, `auto-rows-max`, `auto-rows-fr`

### Gap
- `gap-0` through `gap-96` - Gap on all sides
- `gap-x-{value}` - Column gap
- `gap-y-{value}` - Row gap
- `gap-px` - 1px gap

### Justify Content
- `justify-normal` - Justify content normal
- `justify-start` - Justify content flex-start
- `justify-end` - Justify content flex-end
- `justify-center` - Justify content center
- `justify-between` - Justify content space-between
- `justify-around` - Justify content space-around
- `justify-evenly` - Justify content space-evenly
- `justify-stretch` - Justify content stretch

### Justify Items
- `justify-items-start`, `justify-items-end`, `justify-items-center`
- `justify-items-stretch`

### Justify Self
- `justify-self-auto`, `justify-self-start`, `justify-self-end`
- `justify-self-center`, `justify-self-stretch`

### Align Content
- `content-normal` - Align content normal
- `content-center` - Align content center
- `content-start` - Align content flex-start
- `content-end` - Align content flex-end
- `content-between` - Align content space-between
- `content-around` - Align content space-around
- `content-evenly` - Align content space-evenly
- `content-baseline` - Align content baseline
- `content-stretch` - Align content stretch

### Align Items
- `items-start` - Align items flex-start
- `items-end` - Align items flex-end
- `items-center` - Align items center
- `items-baseline` - Align items baseline
- `items-stretch` - Align items stretch

### Align Self
- `self-auto` - Align self auto
- `self-start` - Align self flex-start
- `self-end` - Align self flex-end
- `self-center` - Align self center
- `self-stretch` - Align self stretch
- `self-baseline` - Align self baseline

### Place Content
- `place-content-center`, `place-content-start`, `place-content-end`
- `place-content-between`, `place-content-around`, `place-content-evenly`
- `place-content-baseline`, `place-content-stretch`

### Place Items
- `place-items-start`, `place-items-end`, `place-items-center`
- `place-items-baseline`, `place-items-stretch`

### Place Self
- `place-self-auto`, `place-self-start`, `place-self-end`
- `place-self-center`, `place-self-stretch`

---

## Spacing

### Padding
- `p-0` through `p-96` - Padding all sides
- `px-{value}` - Padding left and right
- `py-{value}` - Padding top and bottom
- `ps-{value}` - Padding inline start
- `pe-{value}` - Padding inline end
- `pt-{value}` - Padding top
- `pr-{value}` - Padding right
- `pb-{value}` - Padding bottom
- `pl-{value}` - Padding left
- `p-px` - 1px padding

### Margin
- `m-0` through `m-96` - Margin all sides
- `mx-{value}` - Margin left and right
- `my-{value}` - Margin top and bottom
- `ms-{value}` - Margin inline start
- `me-{value}` - Margin inline end
- `mt-{value}` - Margin top
- `mr-{value}` - Margin right
- `mb-{value}` - Margin bottom
- `ml-{value}` - Margin left
- `m-auto` - Margin auto
- `m-px` - 1px margin
- Negative values: `-m-{value}`, `-mx-{value}`, `-my-{value}`, `-mt-{value}`, etc.

### Space Between
- `space-x-{value}` - Horizontal space between children
- `space-y-{value}` - Vertical space between children
- `space-x-reverse`, `space-y-reverse` - Reverse space direction
- Negative values: `-space-x-{value}`, `-space-y-{value}`

---

## Sizing

### Width
- `w-0` through `w-96` - Fixed width
- `w-auto` - Width auto
- `w-px` - 1px width
- `w-0.5`, `w-1.5`, `w-2.5`, `w-3.5` - Fractional widths
- `w-1/2`, `w-1/3`, `w-2/3`, `w-1/4`, `w-2/4`, `w-3/4`
- `w-1/5`, `w-2/5`, `w-3/5`, `w-4/5`
- `w-1/6`, `w-2/6`, `w-3/6`, `w-4/6`, `w-5/6`
- `w-1/12`, `w-2/12`, ... `w-11/12`
- `w-full` - 100% width
- `w-screen` - 100vw
- `w-svw` - 100svw (small viewport width)
- `w-lvw` - 100lvw (large viewport width)
- `w-dvw` - 100dvw (dynamic viewport width)
- `w-min` - Min content
- `w-max` - Max content
- `w-fit` - Fit content

### Min-Width
- `min-w-0` through `min-w-96` - Minimum width
- `min-w-full`, `min-w-min`, `min-w-max`, `min-w-fit`
- `min-w-px` - 1px min-width

### Max-Width
- `max-w-0` through `max-w-96` - Maximum width
- `max-w-none` - Max-width none
- `max-w-xs`, `max-w-sm`, `max-w-md`, `max-w-lg`, `max-w-xl`
- `max-w-2xl`, `max-w-3xl`, `max-w-4xl`, `max-w-5xl`, `max-w-6xl`, `max-w-7xl`
- `max-w-full`, `max-w-min`, `max-w-max`, `max-w-fit`
- `max-w-prose` - 65ch
- `max-w-screen-sm`, `max-w-screen-md`, `max-w-screen-lg`, `max-w-screen-xl`, `max-w-screen-2xl`

### Height
- `h-0` through `h-96` - Fixed height
- `h-auto` - Height auto
- `h-px` - 1px height
- `h-0.5`, `h-1.5`, `h-2.5`, `h-3.5` - Fractional heights
- `h-1/2`, `h-1/3`, `h-2/3`, `h-1/4`, `h-2/4`, `h-3/4`
- `h-1/5`, `h-2/5`, `h-3/5`, `h-4/5`
- `h-1/6`, `h-2/6`, `h-3/6`, `h-4/6`, `h-5/6`
- `h-full` - 100% height
- `h-screen` - 100vh
- `h-svh` - 100svh (small viewport height)
- `h-lvh` - 100lvh (large viewport height)
- `h-dvh` - 100dvh (dynamic viewport height)
- `h-min` - Min content
- `h-max` - Max content
- `h-fit` - Fit content

### Min-Height
- `min-h-0` through `min-h-96` - Minimum height
- `min-h-full`, `min-h-screen`
- `min-h-svh`, `min-h-lvh`, `min-h-dvh`
- `min-h-min`, `min-h-max`, `min-h-fit`
- `min-h-px` - 1px min-height

### Max-Height
- `max-h-0` through `max-h-96` - Maximum height
- `max-h-none` - Max-height none
- `max-h-full`, `max-h-screen`
- `max-h-svh`, `max-h-lvh`, `max-h-dvh`
- `max-h-min`, `max-h-max`, `max-h-fit`
- `max-h-px` - 1px max-height

### Size
- `size-0` through `size-96` - Width and height
- `size-auto`, `size-full`, `size-min`, `size-max`, `size-fit`
- `size-px` - 1px size

---

## Typography

### Font Family
- `font-sans` - Sans-serif font
- `font-serif` - Serif font
- `font-mono` - Monospace font

### Font Size
- `text-xs` - 0.75rem (12px)
- `text-sm` - 0.875rem (14px)
- `text-base` - 1rem (16px)
- `text-lg` - 1.125rem (18px)
- `text-xl` - 1.25rem (20px)
- `text-2xl` - 1.5rem (24px)
- `text-3xl` - 1.875rem (30px)
- `text-4xl` - 2.25rem (36px)
- `text-5xl` - 3rem (48px)
- `text-6xl` - 3.75rem (60px)
- `text-7xl` - 4.5rem (72px)
- `text-8xl` - 6rem (96px)
- `text-9xl` - 8rem (128px)

### Font Smoothing
- `antialiased` - Font smoothing antialiased
- `subpixel-antialiased` - Font smoothing subpixel-antialiased

### Font Style
- `italic` - Font style italic
- `not-italic` - Font style normal

### Font Weight
- `font-thin` - Font weight 100
- `font-extralight` - Font weight 200
- `font-light` - Font weight 300
- `font-normal` - Font weight 400
- `font-medium` - Font weight 500
- `font-semibold` - Font weight 600
- `font-bold` - Font weight 700
- `font-extrabold` - Font weight 800
- `font-black` - Font weight 900

### Font Variant Numeric
- `normal-nums` - Font variant numeric normal
- `ordinal` - Ordinal
- `slashed-zero` - Slashed zero
- `lining-nums` - Lining nums
- `oldstyle-nums` - Oldstyle nums
- `proportional-nums` - Proportional nums
- `tabular-nums` - Tabular nums
- `diagonal-fractions` - Diagonal fractions
- `stacked-fractions` - Stacked fractions

### Letter Spacing
- `tracking-tighter` - Letter spacing -0.05em
- `tracking-tight` - Letter spacing -0.025em
- `tracking-normal` - Letter spacing 0em
- `tracking-wide` - Letter spacing 0.025em
- `tracking-wider` - Letter spacing 0.05em
- `tracking-widest` - Letter spacing 0.1em

### Line Clamp
- `line-clamp-1` through `line-clamp-6` - Line clamp
- `line-clamp-none` - Line clamp none

### Line Height
- `leading-3` through `leading-10` - Fixed line height
- `leading-none` - Line height 1
- `leading-tight` - Line height 1.25
- `leading-snug` - Line height 1.375
- `leading-normal` - Line height 1.5
- `leading-relaxed` - Line height 1.625
- `leading-loose` - Line height 2

### List Style Image
- `list-image-none` - List style image none

### List Style Position
- `list-inside` - List style position inside
- `list-outside` - List style position outside

### List Style Type
- `list-none` - List style none
- `list-disc` - List style disc
- `list-decimal` - List style decimal

### Text Align
- `text-left` - Text align left
- `text-center` - Text align center
- `text-right` - Text align right
- `text-justify` - Text align justify
- `text-start` - Text align start
- `text-end` - Text align end

### Text Color
- `text-inherit` - Text color inherit
- `text-current` - Text color currentColor
- `text-transparent` - Text color transparent
- `text-black` - Text color black
- `text-white` - Text color white
- `text-slate-{50-950}` - Slate colors (50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950)
- `text-gray-{50-950}` - Gray colors
- `text-zinc-{50-950}` - Zinc colors
- `text-neutral-{50-950}` - Neutral colors
- `text-stone-{50-950}` - Stone colors
- `text-red-{50-950}` - Red colors
- `text-orange-{50-950}` - Orange colors
- `text-amber-{50-950}` - Amber colors
- `text-yellow-{50-950}` - Yellow colors
- `text-lime-{50-950}` - Lime colors
- `text-green-{50-950}` - Green colors
- `text-emerald-{50-950}` - Emerald colors
- `text-teal-{50-950}` - Teal colors
- `text-cyan-{50-950}` - Cyan colors
- `text-sky-{50-950}` - Sky colors
- `text-blue-{50-950}` - Blue colors
- `text-indigo-{50-950}` - Indigo colors
- `text-violet-{50-950}` - Violet colors
- `text-purple-{50-950}` - Purple colors
- `text-fuchsia-{50-950}` - Fuchsia colors
- `text-pink-{50-950}` - Pink colors
- `text-rose-{50-950}` - Rose colors

### Text Decoration
- `underline` - Text decoration underline
- `overline` - Text decoration overline
- `line-through` - Text decoration line-through
- `no-underline` - Text decoration none

### Text Decoration Color
- `decoration-inherit`, `decoration-current`, `decoration-transparent`
- `decoration-black`, `decoration-white`
- `decoration-{color}-{shade}` - Same color palette as text colors

### Text Decoration Style
- `decoration-solid` - Text decoration style solid
- `decoration-double` - Text decoration style double
- `decoration-dotted` - Text decoration style dotted
- `decoration-dashed` - Text decoration style dashed
- `decoration-wavy` - Text decoration style wavy

### Text Decoration Thickness
- `decoration-auto` - Text decoration thickness auto
- `decoration-from-font` - Text decoration thickness from-font
- `decoration-0` through `decoration-8` - Text decoration thickness

### Text Underline Offset
- `underline-offset-auto` - Text underline offset auto
- `underline-offset-0` through `underline-offset-8` - Text underline offset

### Text Transform
- `uppercase` - Text transform uppercase
- `lowercase` - Text transform lowercase
- `capitalize` - Text transform capitalize
- `normal-case` - Text transform none

### Text Overflow
- `truncate` - Text overflow ellipsis
- `text-ellipsis` - Text overflow ellipsis
- `text-clip` - Text overflow clip

### Text Wrap
- `text-wrap` - Text wrap wrap
- `text-nowrap` - Text wrap nowrap
- `text-balance` - Text wrap balance
- `text-pretty` - Text wrap pretty

### Text Indent
- `indent-0` through `indent-96` - Text indent
- `indent-px` - 1px text indent
- Negative values: `-indent-{value}`

### Vertical Align
- `align-baseline` - Vertical align baseline
- `align-top` - Vertical align top
- `align-middle` - Vertical align middle
- `align-bottom` - Vertical align bottom
- `align-text-top` - Vertical align text-top
- `align-text-bottom` - Vertical align text-bottom
- `align-sub` - Vertical align sub
- `align-super` - Vertical align super

### Whitespace
- `whitespace-normal` - Whitespace normal
- `whitespace-nowrap` - Whitespace nowrap
- `whitespace-pre` - Whitespace pre
- `whitespace-pre-line` - Whitespace pre-line
- `whitespace-pre-wrap` - Whitespace pre-wrap
- `whitespace-break-spaces` - Whitespace break-spaces

### Word Break
- `break-normal` - Word break normal
- `break-words` - Word break break-word
- `break-all` - Word break break-all
- `break-keep` - Word break keep-all

### Hyphens
- `hyphens-none` - Hyphens none
- `hyphens-manual` - Hyphens manual
- `hyphens-auto` - Hyphens auto

### Content
- `content-none` - Content none

---

## Backgrounds

### Background Attachment
- `bg-fixed` - Background attachment fixed
- `bg-local` - Background attachment local
- `bg-scroll` - Background attachment scroll

### Background Clip
- `bg-clip-border` - Background clip border-box
- `bg-clip-padding` - Background clip padding-box
- `bg-clip-content` - Background clip content-box
- `bg-clip-text` - Background clip text

### Background Color
- `bg-inherit` - Background color inherit
- `bg-current` - Background color currentColor
- `bg-transparent` - Background color transparent
- `bg-black` - Background color black
- `bg-white` - Background color white
- `bg-slate-{50-950}` - Slate colors
- `bg-gray-{50-950}` - Gray colors
- `bg-zinc-{50-950}` - Zinc colors
- `bg-neutral-{50-950}` - Neutral colors
- `bg-stone-{50-950}` - Stone colors
- `bg-red-{50-950}` - Red colors
- `bg-orange-{50-950}` - Orange colors
- `bg-amber-{50-950}` - Amber colors
- `bg-yellow-{50-950}` - Yellow colors
- `bg-lime-{50-950}` - Lime colors
- `bg-green-{50-950}` - Green colors
- `bg-emerald-{50-950}` - Emerald colors
- `bg-teal-{50-950}` - Teal colors
- `bg-cyan-{50-950}` - Cyan colors
- `bg-sky-{50-950}` - Sky colors
- `bg-blue-{50-950}` - Blue colors
- `bg-indigo-{50-950}` - Indigo colors
- `bg-violet-{50-950}` - Violet colors
- `bg-purple-{50-950}` - Purple colors
- `bg-fuchsia-{50-950}` - Fuchsia colors
- `bg-pink-{50-950}` - Pink colors
- `bg-rose-{50-950}` - Rose colors

### Background Origin
- `bg-origin-border` - Background origin border-box
- `bg-origin-padding` - Background origin padding-box
- `bg-origin-content` - Background origin content-box

### Background Position
- `bg-bottom`, `bg-center`, `bg-left`
- `bg-left-bottom`, `bg-left-top`
- `bg-right`, `bg-right-bottom`, `bg-right-top`
- `bg-top`

### Background Repeat
- `bg-repeat` - Background repeat
- `bg-no-repeat` - Background no-repeat
- `bg-repeat-x` - Background repeat-x
- `bg-repeat-y` - Background repeat-y
- `bg-repeat-round` - Background repeat round
- `bg-repeat-space` - Background repeat space

### Background Size
- `bg-auto` - Background size auto
- `bg-cover` - Background size cover
- `bg-contain` - Background size contain

### Background Image
- `bg-none` - Background image none
- `bg-gradient-to-t` - Gradient to top
- `bg-gradient-to-tr` - Gradient to top-right
- `bg-gradient-to-r` - Gradient to right
- `bg-gradient-to-br` - Gradient to bottom-right
- `bg-gradient-to-b` - Gradient to bottom
- `bg-gradient-to-bl` - Gradient to bottom-left
- `bg-gradient-to-l` - Gradient to left
- `bg-gradient-to-tl` - Gradient to top-left

### Gradient Color Stops
- `from-{color}-{shade}` - Gradient from color
- `via-{color}-{shade}` - Gradient via color
- `to-{color}-{shade}` - Gradient to color
- Same color palette as background colors

---

## Borders

### Border Radius
- `rounded-none` - Border radius 0
- `rounded-sm` - Border radius 0.125rem
- `rounded` - Border radius 0.25rem
- `rounded-md` - Border radius 0.375rem
- `rounded-lg` - Border radius 0.5rem
- `rounded-xl` - Border radius 0.75rem
- `rounded-2xl` - Border radius 1rem
- `rounded-3xl` - Border radius 1.5rem
- `rounded-full` - Border radius 9999px
- `rounded-t-{size}` - Top corners
- `rounded-r-{size}` - Right corners
- `rounded-b-{size}` - Bottom corners
- `rounded-l-{size}` - Left corners
- `rounded-s-{size}` - Start corners
- `rounded-e-{size}` - End corners
- `rounded-tl-{size}` - Top-left corner
- `rounded-tr-{size}` - Top-right corner
- `rounded-br-{size}` - Bottom-right corner
- `rounded-bl-{size}` - Bottom-left corner
- `rounded-ss-{size}` - Start-start corner
- `rounded-se-{size}` - Start-end corner
- `rounded-ee-{size}` - End-end corner
- `rounded-es-{size}` - End-start corner

### Border Width
- `border-0` through `border-8` - Border all sides
- `border` - Border 1px
- `border-x-{width}` - Border left and right
- `border-y-{width}` - Border top and bottom
- `border-s-{width}` - Border inline start
- `border-e-{width}` - Border inline end
- `border-t-{width}` - Border top
- `border-r-{width}` - Border right
- `border-b-{width}` - Border bottom
- `border-l-{width}` - Border left

### Border Color
- `border-inherit`, `border-current`, `border-transparent`
- `border-black`, `border-white`
- `border-{color}-{shade}` - Same color palette as background colors
- Side-specific: `border-x-{color}`, `border-y-{color}`, `border-s-{color}`, `border-e-{color}`, `border-t-{color}`, `border-r-{color}`, `border-b-{color}`, `border-l-{color}`

### Border Style
- `border-solid` - Border style solid
- `border-dashed` - Border style dashed
- `border-dotted` - Border style dotted
- `border-double` - Border style double
- `border-hidden` - Border style hidden
- `border-none` - Border style none

### Divide Width
- `divide-x-0` through `divide-x-8` - Horizontal divide width
- `divide-y-0` through `divide-y-8` - Vertical divide width
- `divide-x`, `divide-y` - 1px divide
- `divide-x-reverse`, `divide-y-reverse` - Reverse divide

### Divide Color
- `divide-inherit`, `divide-current`, `divide-transparent`
- `divide-{color}-{shade}` - Same color palette as border colors

### Divide Style
- `divide-solid`, `divide-dashed`, `divide-dotted`, `divide-double`, `divide-none`

### Outline Width
- `outline-0` through `outline-8` - Outline width
- `outline` - Outline 1px

### Outline Color
- `outline-inherit`, `outline-current`, `outline-transparent`
- `outline-{color}-{shade}` - Same color palette as border colors

### Outline Style
- `outline-none` - Outline style none
- `outline` - Outline style solid
- `outline-dashed` - Outline style dashed
- `outline-dotted` - Outline style dotted
- `outline-double` - Outline style double

### Outline Offset
- `outline-offset-0` through `outline-offset-8` - Outline offset

### Ring Width
- `ring-0` through `ring-8` - Ring width
- `ring` - Ring 3px
- `ring-inset` - Ring inset

### Ring Color
- `ring-inherit`, `ring-current`, `ring-transparent`
- `ring-{color}-{shade}` - Same color palette as border colors

### Ring Offset Width
- `ring-offset-0` through `ring-offset-8` - Ring offset width

### Ring Offset Color
- `ring-offset-inherit`, `ring-offset-current`, `ring-offset-transparent`
- `ring-offset-{color}-{shade}` - Same color palette as border colors

---

## Effects

### Box Shadow
- `shadow-sm` - Small shadow
- `shadow` - Default shadow
- `shadow-md` - Medium shadow
- `shadow-lg` - Large shadow
- `shadow-xl` - Extra large shadow
- `shadow-2xl` - 2XL shadow
- `shadow-inner` - Inner shadow
- `shadow-none` - No shadow

### Box Shadow Color
- `shadow-inherit`, `shadow-current`, `shadow-transparent`
- `shadow-{color}-{shade}` - Same color palette as border colors

### Opacity
- `opacity-0` through `opacity-100` - Opacity (0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100)

### Mix Blend Mode
- `mix-blend-normal`, `mix-blend-multiply`, `mix-blend-screen`
- `mix-blend-overlay`, `mix-blend-darken`, `mix-blend-lighten`
- `mix-blend-color-dodge`, `mix-blend-color-burn`, `mix-blend-hard-light`
- `mix-blend-soft-light`, `mix-blend-difference`, `mix-blend-exclusion`
- `mix-blend-hue`, `mix-blend-saturation`, `mix-blend-color`, `mix-blend-luminosity`
- `mix-blend-plus-darker`, `mix-blend-plus-lighter`

### Background Blend Mode
- `bg-blend-normal`, `bg-blend-multiply`, `bg-blend-screen`
- `bg-blend-overlay`, `bg-blend-darken`, `bg-blend-lighten`
- `bg-blend-color-dodge`, `bg-blend-color-burn`, `bg-blend-hard-light`
- `bg-blend-soft-light`, `bg-blend-difference`, `bg-blend-exclusion`
- `bg-blend-hue`, `bg-blend-saturation`, `bg-blend-color`, `bg-blend-luminosity`

---

## Filters

### Blur
- `blur-none` - Blur 0
- `blur-sm` - Blur 4px
- `blur` - Blur 8px
- `blur-md` - Blur 12px
- `blur-lg` - Blur 16px
- `blur-xl` - Blur 24px
- `blur-2xl` - Blur 40px
- `blur-3xl` - Blur 64px

### Brightness
- `brightness-0` through `brightness-200` - Brightness (0, 50, 75, 90, 95, 100, 105, 110, 125, 150, 200)

### Contrast
- `contrast-0` through `contrast-200` - Contrast (0, 50, 75, 100, 125, 150, 200)

### Drop Shadow
- `drop-shadow-sm` - Small drop shadow
- `drop-shadow` - Default drop shadow
- `drop-shadow-md` - Medium drop shadow
- `drop-shadow-lg` - Large drop shadow
- `drop-shadow-xl` - Extra large drop shadow
- `drop-shadow-2xl` - 2XL drop shadow
- `drop-shadow-none` - No drop shadow

### Grayscale
- `grayscale-0` - Grayscale 0
- `grayscale` - Grayscale 100%

### Hue Rotate
- `hue-rotate-0`, `hue-rotate-15`, `hue-rotate-30`, `hue-rotate-60`
- `hue-rotate-90`, `hue-rotate-180`
- Negative values: `-hue-rotate-{value}`

### Invert
- `invert-0` - Invert 0
- `invert` - Invert 100%

### Saturate
- `saturate-0` through `saturate-200` - Saturate (0, 50, 100, 150, 200)

### Sepia
- `sepia-0` - Sepia 0
- `sepia` - Sepia 100%

### Backdrop Blur
- `backdrop-blur-none` through `backdrop-blur-3xl` - Same as blur

### Backdrop Brightness
- `backdrop-brightness-0` through `backdrop-brightness-200` - Same as brightness

### Backdrop Contrast
- `backdrop-contrast-0` through `backdrop-contrast-200` - Same as contrast

### Backdrop Grayscale
- `backdrop-grayscale-0`, `backdrop-grayscale`

### Backdrop Hue Rotate
- `backdrop-hue-rotate-0` through `backdrop-hue-rotate-180` - Same as hue-rotate

### Backdrop Invert
- `backdrop-invert-0`, `backdrop-invert`

### Backdrop Opacity
- `backdrop-opacity-0` through `backdrop-opacity-100` - Same as opacity

### Backdrop Saturate
- `backdrop-saturate-0` through `backdrop-saturate-200` - Same as saturate

### Backdrop Sepia
- `backdrop-sepia-0`, `backdrop-sepia`

---

## Tables

### Border Collapse
- `border-collapse` - Border collapse collapse
- `border-separate` - Border collapse separate

### Border Spacing
- `border-spacing-0` through `border-spacing-96` - Border spacing
- `border-spacing-x-{value}` - Horizontal border spacing
- `border-spacing-y-{value}` - Vertical border spacing
- `border-spacing-px` - 1px border spacing

### Table Layout
- `table-auto` - Table layout auto
- `table-fixed` - Table layout fixed

### Caption Side
- `caption-top` - Caption side top
- `caption-bottom` - Caption side bottom

---

## Transitions & Animation

### Transition Property
- `transition-none` - Transition none
- `transition-all` - Transition all
- `transition` - Transition default properties
- `transition-colors` - Transition color properties
- `transition-opacity` - Transition opacity
- `transition-shadow` - Transition shadow
- `transition-transform` - Transition transform

### Transition Duration
- `duration-0` - Duration 0ms
- `duration-75` - Duration 75ms
- `duration-100` - Duration 100ms
- `duration-150` - Duration 150ms
- `duration-200` - Duration 200ms
- `duration-300` - Duration 300ms
- `duration-500` - Duration 500ms
- `duration-700` - Duration 700ms
- `duration-1000` - Duration 1000ms

### Transition Timing Function
- `ease-linear` - Timing function linear
- `ease-in` - Timing function cubic-bezier(0.4, 0, 1, 1)
- `ease-out` - Timing function cubic-bezier(0, 0, 0.2, 1)
- `ease-in-out` - Timing function cubic-bezier(0.4, 0, 0.2, 1)

### Transition Delay
- `delay-0` - Delay 0ms
- `delay-75` - Delay 75ms
- `delay-100` - Delay 100ms
- `delay-150` - Delay 150ms
- `delay-200` - Delay 200ms
- `delay-300` - Delay 300ms
- `delay-500` - Delay 500ms
- `delay-700` - Delay 700ms
- `delay-1000` - Delay 1000ms

### Animation
- `animate-none` - Animation none
- `animate-spin` - Spin animation
- `animate-ping` - Ping animation
- `animate-pulse` - Pulse animation
- `animate-bounce` - Bounce animation

---

## Transforms

### Scale
- `scale-0` through `scale-150` - Scale both axes (0, 50, 75, 90, 95, 100, 105, 110, 125, 150)
- `scale-x-{value}` - Scale X axis
- `scale-y-{value}` - Scale Y axis

### Rotate
- `rotate-0`, `rotate-1`, `rotate-2`, `rotate-3`, `rotate-6`, `rotate-12`
- `rotate-45`, `rotate-90`, `rotate-180`
- Negative values: `-rotate-{value}`

### Translate
- `translate-x-0` through `translate-x-96` - Translate X
- `translate-y-0` through `translate-y-96` - Translate Y
- `translate-x-px`, `translate-y-px` - 1px translate
- `translate-x-1/2`, `translate-x-1/3`, `translate-x-2/3`, `translate-x-1/4`, `translate-x-2/4`, `translate-x-3/4`
- `translate-x-full` - Translate X 100%
- Same fractions for translate-y
- Negative values: `-translate-x-{value}`, `-translate-y-{value}`

### Skew
- `skew-x-0` through `skew-x-12` - Skew X (0, 1, 2, 3, 6, 12 degrees)
- `skew-y-0` through `skew-y-12` - Skew Y
- Negative values: `-skew-x-{value}`, `-skew-y-{value}`

### Transform Origin
- `origin-center`, `origin-top`, `origin-top-right`
- `origin-right`, `origin-bottom-right`, `origin-bottom`
- `origin-bottom-left`, `origin-left`, `origin-top-left`

---

## Interactivity

### Accent Color
- `accent-auto` - Accent color auto
- `accent-{color}-{shade}` - Same color palette as background colors

### Appearance
- `appearance-none` - Appearance none
- `appearance-auto` - Appearance auto

### Cursor
- `cursor-auto`, `cursor-default`, `cursor-pointer`
- `cursor-wait`, `cursor-text`, `cursor-move`
- `cursor-help`, `cursor-not-allowed`, `cursor-none`
- `cursor-context-menu`, `cursor-progress`, `cursor-cell`
- `cursor-crosshair`, `cursor-vertical-text`, `cursor-alias`
- `cursor-copy`, `cursor-no-drop`, `cursor-grab`, `cursor-grabbing`
- `cursor-all-scroll`, `cursor-col-resize`, `cursor-row-resize`
- `cursor-n-resize`, `cursor-e-resize`, `cursor-s-resize`, `cursor-w-resize`
- `cursor-ne-resize`, `cursor-nw-resize`, `cursor-se-resize`, `cursor-sw-resize`
- `cursor-ew-resize`, `cursor-ns-resize`, `cursor-nesw-resize`, `cursor-nwse-resize`
- `cursor-zoom-in`, `cursor-zoom-out`

### Caret Color
- `caret-inherit`, `caret-current`, `caret-transparent`
- `caret-{color}-{shade}` - Same color palette as text colors

### Pointer Events
- `pointer-events-none` - Pointer events none
- `pointer-events-auto` - Pointer events auto

### Resize
- `resize-none` - Resize none
- `resize` - Resize both
- `resize-y` - Resize vertical
- `resize-x` - Resize horizontal

### Scroll Behavior
- `scroll-auto` - Scroll behavior auto
- `scroll-smooth` - Scroll behavior smooth

### Scroll Margin
- `scroll-m-0` through `scroll-m-96` - Scroll margin all sides
- `scroll-mx-{value}`, `scroll-my-{value}` - Horizontal/vertical
- `scroll-ms-{value}`, `scroll-me-{value}` - Inline start/end
- `scroll-mt-{value}`, `scroll-mr-{value}`, `scroll-mb-{value}`, `scroll-ml-{value}` - Individual sides
- `scroll-m-px` - 1px scroll margin

### Scroll Padding
- `scroll-p-0` through `scroll-p-96` - Scroll padding all sides
- `scroll-px-{value}`, `scroll-py-{value}` - Horizontal/vertical
- `scroll-ps-{value}`, `scroll-pe-{value}` - Inline start/end
- `scroll-pt-{value}`, `scroll-pr-{value}`, `scroll-pb-{value}`, `scroll-pl-{value}` - Individual sides
- `scroll-p-px` - 1px scroll padding

### Scroll Snap Align
- `snap-start` - Scroll snap align start
- `snap-end` - Scroll snap align end
- `snap-center` - Scroll snap align center
- `snap-align-none` - Scroll snap align none

### Scroll Snap Stop
- `snap-normal` - Scroll snap stop normal
- `snap-always` - Scroll snap stop always

### Scroll Snap Type
- `snap-none` - Scroll snap type none
- `snap-x` - Scroll snap type x
- `snap-y` - Scroll snap type y
- `snap-both` - Scroll snap type both
- `snap-mandatory` - Scroll snap type mandatory
- `snap-proximity` - Scroll snap type proximity

### Touch Action
- `touch-auto` - Touch action auto
- `touch-none` - Touch action none
- `touch-pan-x` - Touch action pan-x
- `touch-pan-left` - Touch action pan-left
- `touch-pan-right` - Touch action pan-right
- `touch-pan-y` - Touch action pan-y
- `touch-pan-up` - Touch action pan-up
- `touch-pan-down` - Touch action pan-down
- `touch-pinch-zoom` - Touch action pinch-zoom
- `touch-manipulation` - Touch action manipulation

### User Select
- `select-none` - User select none
- `select-text` - User select text
- `select-all` - User select all
- `select-auto` - User select auto

### Will Change
- `will-change-auto` - Will change auto
- `will-change-scroll` - Will change scroll-position
- `will-change-contents` - Will change contents
- `will-change-transform` - Will change transform

---

## SVG

### Fill
- `fill-none` - Fill none
- `fill-inherit` - Fill inherit
- `fill-current` - Fill currentColor
- `fill-transparent` - Fill transparent
- `fill-black`, `fill-white`
- `fill-{color}-{shade}` - Same color palette as background colors

### Stroke
- `stroke-none` - Stroke none
- `stroke-inherit` - Stroke inherit
- `stroke-current` - Stroke currentColor
- `stroke-transparent` - Stroke transparent
- `stroke-black`, `stroke-white`
- `stroke-{color}-{shade}` - Same color palette as background colors

### Stroke Width
- `stroke-0`, `stroke-1`, `stroke-2`

---

## Accessibility

### Screen Readers
- `sr-only` - Screen reader only (visually hidden)
- `not-sr-only` - Not screen reader only

### Forced Color Adjust
- `forced-color-adjust-auto` - Forced color adjust auto
- `forced-color-adjust-none` - Forced color adjust none

---

## Responsive Design Modifiers

### Breakpoint Prefixes
All utility classes can be prefixed with responsive breakpoints:
- `sm:` - Small screens (640px and up)
- `md:` - Medium screens (768px and up)
- `lg:` - Large screens (1024px and up)
- `xl:` - Extra large screens (1280px and up)
- `2xl:` - 2X large screens (1536px and up)

**Example**: `sm:text-center`, `md:flex`, `lg:w-1/2`

---

## State Modifiers

### Pseudo-class Variants
- `hover:` - Hover state
- `focus:` - Focus state
- `focus-within:` - Focus within
- `focus-visible:` - Focus visible
- `active:` - Active state
- `visited:` - Visited state
- `target:` - Target state
- `first:` - First child
- `last:` - Last child
- `only:` - Only child
- `odd:` - Odd child
- `even:` - Even child
- `first-of-type:` - First of type
- `last-of-type:` - Last of type
- `only-of-type:` - Only of type
- `empty:` - Empty element
- `disabled:` - Disabled state
- `enabled:` - Enabled state
- `checked:` - Checked state
- `indeterminate:` - Indeterminate state
- `default:` - Default state
- `required:` - Required state
- `valid:` - Valid state
- `invalid:` - Invalid state
- `in-range:` - In range state
- `out-of-range:` - Out of range state
- `placeholder-shown:` - Placeholder shown
- `autofill:` - Autofill state
- `read-only:` - Read only state

### Pseudo-element Variants
- `before:` - ::before pseudo-element
- `after:` - ::after pseudo-element
- `first-letter:` - ::first-letter pseudo-element
- `first-line:` - ::first-line pseudo-element
- `marker:` - ::marker pseudo-element
- `selection:` - ::selection pseudo-element
- `file:` - ::file-selector-button pseudo-element
- `placeholder:` - ::placeholder pseudo-element
- `backdrop:` - ::backdrop pseudo-element

### Media Query Variants
- `dark:` - Dark mode
- `portrait:` - Portrait orientation
- `landscape:` - Landscape orientation
- `motion-safe:` - Prefers reduced motion: no-preference
- `motion-reduce:` - Prefers reduced motion: reduce
- `contrast-more:` - Prefers contrast: more
- `contrast-less:` - Prefers contrast: less
- `print:` - Print media

### Attribute Variants
- `rtl:` - Right-to-left direction
- `ltr:` - Left-to-right direction
- `open:` - Open state (for details/dialog)

### Advanced Variants
- `group-hover:` - Hover on parent with class "group"
- `group-focus:` - Focus on parent with class "group"
- `peer-hover:` - Hover on sibling with class "peer"
- `peer-focus:` - Focus on sibling with class "peer"
- `peer-checked:` - Checked on sibling with class "peer"
- `has-{selector}:` - Has selector

**Example**: `hover:bg-blue-500`, `focus:ring-2`, `dark:text-white`

---

## Arbitrary Values

Tailwind CSS supports arbitrary values for most utilities using square brackets:

### Examples
- `w-[137px]` - Custom width
- `bg-[#1da1f2]` - Custom color
- `text-[14px]` - Custom font size
- `p-[17px]` - Custom padding
- `grid-cols-[200px_minmax(900px,_1fr)_100px]` - Custom grid
- `before:content-['Hello']` - Custom content

---

## Important Modifier

Add `!` prefix to make any utility important:
- `!text-center` - text-align: center !important
- `!bg-red-500` - background-color: rgb(239 68 68) !important

---

## Best Practices for Building Websites

### Common Layout Patterns
1. **Container**: `container mx-auto px-4`
2. **Flex Center**: `flex items-center justify-center`
3. **Grid Layout**: `grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4`
4. **Card**: `bg-white rounded-lg shadow-md p-6`
5. **Button**: `bg-blue-500 hover:bg-blue-600 text-white font-bold py-2 px-4 rounded`

### Responsive Design
- Mobile-first approach: Start with base styles, add breakpoint prefixes for larger screens
- `sm:`, `md:`, `lg:`, `xl:`, `2xl:` breakpoints

### Dark Mode
- Add `dark:` prefix: `bg-white dark:bg-gray-800 text-black dark:text-white`

### Accessibility
- Use `sr-only` for screen reader text
- Ensure proper focus states with `focus:` variants
- Use semantic HTML with utility classes

---

**Document End**

*This comprehensive list includes all major Tailwind CSS utility classes as of Tailwind CSS v3.x. Each class can be combined with responsive, state, and other modifiers to create complex, responsive designs.*
