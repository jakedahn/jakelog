// data = {
//   get_url: 'http://jakedahn.com/1-foo-bar',
//   post_url: 'http://jakedahn.com/edit/1-foo-bar
//   parsed_body: '<p>parsed content here</p>',
//   raw_body: 'raw content here'
// }

var Post;

Post = (function() {
  function Post( data ) {
    this.get_url = data.get_url || ""
    this.put_url = data.put_url || ""
    this.parsed_body = data.parsed_url || ""
    this.raw_body = data.raw_body || ""
    this.editor = null
    this.init();
  }
  
  Post.prototype.update = function(){
    var self = this;
    var data = {
      raw_body: self.editor.editor.innerText
    }

    $.ajax({
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
      type: 'PUT',
      url: self.put_url+".json",
      data: {post: data},
      success: function(data){
        setTimeout(function(){
          self.update();
        }, 10000)
      }
    })
  }
  
  Post.prototype.init = function(){
    var self = this;
    if (/edit/g.exec(window.location.href)) {
      self.editor = new Editor(self.raw_body);
      self.editor.goDocStart();
      self.editor.focusInput();
      setTimeout(function(){
        self.update();
      }, 10000)
    };
    if (/new/g.exec(window.location.href)) {
      self.editor = new Editor(self.raw_body);
      self.editor.goDocStart();
      self.editor.focusInput();
      if (self.editor.editor.innerText.length >= 100) {
        self.create()
      };
      setTimeout(function(){
        self.update();
      }, 10000)
    };
  }
  
  Post.prototype.create = function(){
    $.ajax({
      beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));},
      type: 'POST',
      url: "/posts/new",
      data: {post: {raw_body: self.editor.editor.innerText}},
      success: function(data){
        console.log("success")
      }
    })
    
  }
  
  return Post;
}());
