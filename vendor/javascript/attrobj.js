// attrobj@3.1.0 downloaded from https://ga.jspm.io/npm:attrobj@3.1.0/lib/attrobj.js

function attrobj(e,t){const a={};Object.keys(t.dataset).forEach(o=>{if(o.match(new RegExp(`^${e}`))&&o!==e){let l=o.replace(e,"");let r=false;if(l.match(/^Global/)){l=l.replace("Global","");r=true}l=`${l[0].toLowerCase()}${l.slice(1)}`;a[l]=r?window[t.dataset[o]]:t.dataset[o];"undefined"!==typeof a[l]&&""!==a[l]||(a[l]=true)}});return a}export default attrobj;

