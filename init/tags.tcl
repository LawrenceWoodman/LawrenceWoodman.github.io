source -directory [dir plugins] layout.tcl
source -directory [dir plugins] posts.tcl
source -directory [dir plugins] tags.tcl
source -directory [dir plugins] www.tcl

proc writeTagPage {tag posts} {
  set tagDirName [tags::toDirName $tag]
  set destination [www::makeDestination blog tag $tagDirName index.html]
  set params [dict create \
    menuOption blog tag $tag posts $posts \
    url /blog/tag/$tagDirName/index.html \
    title "Articles tagged with: $tag" \
  ]
  set content [ornament \
      -params $params \
      -directory [dir content blog] \
      -file tag.html
  ]
  write $destination [layout::render default.tpl $content $params]
}

set allPosts [posts::sort [collection posts]]
set files [read -directory [dir content posts] details.list]
set tags [tags::collect tags $files]
tags::generatePages $allPosts writeTagPage $tags
