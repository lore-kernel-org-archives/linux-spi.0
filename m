From: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Subject: Re: [PATCH v7 3/3] fpga: Add support for Lattice iCE40 FPGAs
Date: Sun, 6 Nov 2016 17:46:03 -0700
Message-ID: <edb1b434-af6c-08aa-c1e6-f67671afcd5f@airwebreathe.org.uk>
References: <1478236004-7852-1-git-send-email-joel@airwebreathe.org.uk>
 <1478236004-7852-3-git-send-email-joel@airwebreathe.org.uk>
 <alpine.DEB.2.10.1611040945100.2940@atull-VirtualBox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: atull <atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.10.1611040945100.2940@atull-VirtualBox>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/spi/spi.h>
>
> Hi Joel,
>
> The build breaks without this:
>
> #include <linux/module.h>
>
> Alan
>

Go it! - thanks!
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
