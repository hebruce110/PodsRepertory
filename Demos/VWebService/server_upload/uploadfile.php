<?php  

if ($_SERVER['REQUEST_METHOD'] == 'POST')  
 {  
         //上传文件类型列表  
    $uptypes=array(  
        'image/jpg',  
        'image/jpeg',  
        'image/png',  
        'image/pjpeg',  
        'image/gif',  
        'image/bmp',  
        'image/x-png' 
    );

    $max_file_size=2000000;     //上传文件大小限制, 单位BYTE  
    $destination_folder="uploadimg/"; //上传文件路径  
    $imgpreview=1;      //是否生成预览图(1为生成,其他为不生成);  
    $imgpreviewsize=1/2;    //缩略图比例  


     if (!is_uploaded_file($_FILES["upfile"][tmp_name]))  
     //是否存在文件  
     {  
        $result['status'] = '10001';
        $result['msg'] = '图片不存在!';
        $result['content'] = '';
        echo json_encode($result);
        exit;  
     }  
   
    $file = $_FILES["upfile"];  
    if($max_file_size < $file["size"])  
    //检查文件大小  
    {  
        $result['status'] = '10002';
        $result['msg'] = '文件太大!';
        $result['content'] = '';
        echo json_encode($result);
        exit;  
    }  
   
    if(!in_array($file["type"], $uptypes))  
    //检查文件类型  
    {  
        $result['status'] = '10003';
        $result['msg'] = "文件类型不符!".$file["type"]; 
        $result['content'] = '';
        echo json_encode($result);
        exit;  
    }  
   
    if(!file_exists($destination_folder))  
    {  
        mkdir($destination_folder);  
    }  
   
    $filename=$file["tmp_name"];  
    $image_size = getimagesize($filename);  
    $pinfo=pathinfo($file["name"]);  
    $ftype=$pinfo['extension'];  
    $destination = $destination_folder.time().".".$ftype;  
    if (file_exists($destination) && $overwrite != true)  
    {  
        $result['status'] = '10004';
        $result['msg'] = '同名文件已经存在了!';
        $result['content'] = '';
        echo json_encode($result);
        exit;  
    }  

    if(!move_uploaded_file ($filename, $destination))  
    {  
        $result['status'] = '10005';
        $result['msg'] = '移动文件出错!';
        $result['content'] = '';
        echo json_encode($result);
        exit;  
    } else {
        $server_ip = shell_exec("/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}' |tr -d '\n'"); 
        $imageInfo['width'] =  $image_size[0];
        $imageInfo['height'] = $image_size[1];
        $imageInfo['url'] = "http://".$server_ip."/".$destination;
        $imageInfo['create_at'] = time();
        $result['status'] = '0';
        $result['msg'] = 'upload successed!';
        $result['content'] = $imageInfo;
        die(json_encode($result));
    }  
  }else {
        $result['status'] = '-10000';
        $result['msg'] = '非法请求!';
        $result['content'] = '';
        echo json_encode($result);
  }
?>