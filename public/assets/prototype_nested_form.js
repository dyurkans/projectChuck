document.observe("click",function(e,t){if(t=e.findElement("form a.add_nested_fields")){var d=t.readAttribute("data-association"),r=t.readAttribute("data-target"),a=$(t.readAttribute("data-blueprint-id")),n=a.readAttribute("data-blueprint"),f=(t.getOffsetParent(".fields").firstDescendant().readAttribute("name")||"").replace(new RegExp("[[a-z_]+]$"),"");if(f){var l=f.match(/[a-z_]+_attributes(?=\]\[(new_)?\d+\])/g)||[],s=f.match(/[0-9]+/g)||[];for(i=0;i<l.length;i++)s[i]&&(n=n.replace(new RegExp("(_"+l[i]+")_.+?_","g"),"$1_"+s[i]+"_"),n=n.replace(new RegExp("(\\["+l[i]+"\\])\\[.+?\\]","g"),"$1["+s[i]+"]"))}var o=new RegExp("new_"+d,"g"),u=(new Date).getTime();n=n.replace(o,u);var c;return c=r?$$(r)[0].insert(n):t.insert({before:n}),c.fire("nested:fieldAdded",{field:c}),c.fire("nested:fieldAdded:"+d,{field:c}),!1}}),document.observe("click",function(e,t){if(t=e.findElement("form a.remove_nested_fields")){var i=t.previous(0),d=t.readAttribute("data-association");i&&(i.value="1");var r=t.up(".fields").hide();return r.fire("nested:fieldRemoved",{field:r}),r.fire("nested:fieldRemoved:"+d,{field:r}),!1}});