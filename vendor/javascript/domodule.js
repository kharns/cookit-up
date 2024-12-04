// domodule@8.2.1 downloaded from https://ga.jspm.io/npm:domodule@8.2.1/dist/domodule.module.js

import{find as e,findOne as o,on as i}from"domassist";import d from"attrobj";function n(){return n=Object.assign?Object.assign.bind():function(e){for(var o=1;o<arguments.length;o++){var i=arguments[o];for(var d in i)({}).hasOwnProperty.call(i,d)&&(e[d]=i[d])}return e},n.apply(null,arguments)}function r(e){var o=function(e){if("object"!=typeof e||!e)return e;var o=e[Symbol.toPrimitive];if(void 0!==o){var i=o.call(e,"string");if("object"!=typeof i)return i;throw new TypeError("@@toPrimitive must return a primitive value.")}return String(e)}(e);return"symbol"==typeof o?o:o+""}function s(e,o){return void 0===o&&(o="module"),e.parentElement?e.parentElement.dataset[o]?e.parentElement:s(e.parentElement):e}var a="[data-action]",u={find:e,findOne:o,on:i},l=function(){function t(e,o){var i=this;return this.el=void 0,this.options=void 0,this.moduleName=void 0,this.els=void 0,this.setUps=void 0,this.id=void 0,this.actionRouter=function(e){var o=e.currentTarget,a=t.parseAction(o).name,u=d("action",o);a&&i[a].call(i,o,e,u)},this.log("Beginning setup"),this.el=e,this.options=n({},this.defaults,d("module",this.el)),this.moduleName=o||this.el.dataset.module||"",this.els={},this.setUps={},this.id="",this.preInit(),this.generateUuid(),this.storeRef(),this.setupActions(),this.setupNamed(),this.verifyRequired(),this.postInit(),this.log("Initalized"),this}var e,o,i=t.prototype;return i.preInit=function(){this.log("No preInit() actions included.")},i.postInit=function(){this.log("No postInit() actions included.")},i.generateUuid=function(){this.id="xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".replace(/[xy]/g,(function(e){var o=16*Math.random()|0;return("x"===e?o:3&o|8).toString(16)}))},i.storeRef=function(){if(void 0===window.domorefs&&(window.domorefs={}),window.domorefs[this.el.dataset.moduleUid||"undefined"])return!1;this.el.dataset.moduleUid=this.id,window.domorefs[this.el.dataset.moduleUid]=this},i.setupActions=function(){var e=this;this.setupAction(this.el),this.find(a).forEach((function(o){s(o)===e.el&&e.setupAction(o)}))},i.setupAction=function(e){if("true"!==e.dataset.domoduleActionProcessed){var o=t.parseAction(e),i=o.name,d=o.type;i&&("function"==typeof this[i]?(this.log(i+" bound"),this.storeSetUp(i,"actions"),u.on(e,d,this.actionRouter),e.dataset.domoduleActionProcessed="true"):this.log(i+" was registered, but there is no function set up"))}},i.setupNamed=function(){var e=this;this.find("[data-name]").forEach((function(o){if(o.dataset.name){var i=o.dataset.name;s(o)===e.el&&(o.dataset.domoduleNameProcessed||(e.els[i]?Array.isArray(e.els[i])?e.els[i].push(o):e.els[i]=[e.els[i],o]:e.els[i]=o,e.storeSetUp(o.dataset.name,"named"),o.dataset.domoduleNameProcessed="true",o.dataset.domoduleOwner=e.id))}}))},i.storeSetUp=function(e,o){void 0===this.setUps[o]&&(this.setUps[o]=[]),this.setUps[o].indexOf(e)<0&&this.setUps[o].push(e)},i.verifyRequired=function(){var e,o=this;return null!=(e=this.required)&&null!=(e=e.options)&&e.length&&(this.setUps.options=Object.keys(this.options)),Object.keys(this.required).forEach((function(e){o.required[e].forEach((function(i){if(o.setUps[e].indexOf(i)<0)throw new Error(i+" is required as "+e+" for "+o.moduleName+", but is missing!")}))})),this},i.find=function(e){return u.find(e,this.el)},i.findOne=function(e){return u.findOne(e,this.el)},i.findByName=function(e){return this.els[e]},i.getOption=function(e){return this.options[e]},i.destroy=function(){var e,o=this;u.find(a,null!=(e=this.el.parentElement)?e:void 0).forEach((function(e){if("true"===e.dataset.domoduleActionProcessed){var i=t.parseAction(e);e.removeEventListener(i.type,o.actionRouter),e.dataset.domoduleActionProcessed="false"}}))},i.log=function(e){t.log(this.constructor.name+": "+e)},i.error=function(e){t.error(this.constructor.name+": "+e)},t.parseAction=function(e){var o;return{name:e.dataset.action,type:null!=(o=e.dataset.actionType)?o:"click"}},t.getInstance=function(e){return e.dataset.moduleUid&&window.domorefs?window.domorefs[e.dataset.moduleUid]:(t.log("The dataset of "+(e.getAttribute("id")||"NO ID")+" has no UID."),!1)},t.register=function(e,o){if("string"!=typeof e)e=(o=e).prototype.constructor.name;else if("string"==typeof e&&void 0===o)throw new Error("No Domodule class instance was provided in either parameter.");window.domodules||(window.domodules={}),t.log("Registering "+e),window.domodules[e]=o},t.discover=function(e){if(void 0===e&&(e="body"),t.log("Discovering modules..."),window.domodules){var o;o=e instanceof Element?[e]:Array.isArray(e)?e:u.find(e);var i=[];return o.forEach((function(e){u.find("[data-module]",e).forEach((function(e){var o=e.dataset.module;if(o&&window.domodules&&"function"==typeof window.domodules[o]){if("object"==typeof window.domorefs&&e.dataset.moduleUid&&void 0!==window.domorefs[e.dataset.moduleUid])return;t.log(o+" found");var d=window.domodules[o];i.push(new d(e))}}))})),i}t.log("No modules found")},t.log=function(e){t.debug&&console.log("[DOMODULE] "+e)},t.error=function(e){console.error("[DOMODULE] "+e)},e=t,(o=[{key:"required",get:function(){return{}}},{key:"defaults",get:function(){return{}}}])&&function(e,o){for(var i=0;i<o.length;i++){var d=o[i];d.enumerable=d.enumerable||!1,d.configurable=!0,"value"in d&&(d.writable=!0),Object.defineProperty(e,r(d.key),d)}}(e.prototype,o),Object.defineProperty(e,"prototype",{writable:!1}),e}();l.autoDiscover=void 0,l.debug=void 0,l.debug="object"==typeof window.localStorage&&window.localStorage.getItem("DomoduleDebug"),l.autoDiscover=!0,window.addEventListener("DOMContentLoaded",(function(){l.autoDiscover&&l.discover()}));export{l as default};

