From: Joel Holdsworth <joel-IJEoVVyKhCJXvIrf17iDB/XRex20P6io@public.gmane.org>
Subject: Why isn't spi_set_cs() public?
Date: Tue, 25 Oct 2016 11:03:17 -0600
Message-ID: <937c638f-a3f7-cb68-7f9a-94dd38d52be5@airwebreathe.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: atull-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org
To: broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Folks,

I'm working a little driver for configuring the Lattice iCE40 FPGA in 
the FPGA Manager framework.

https://patchwork.kernel.org/patch/9393981/

It's mostly working now, but I wanted to ask about manually setting the 
slave-select line.

The iCE40 requires master to assert the slave-select, then pulse a reset 
line, then wait a while then release the slave-select.

To do this I lock the bus with spi_bus_lock(), then I copy-pasted code 
from spi_set_cs() into the driver so I could manually control the 
slave-select.

I was wondering if anyone could explain why spi_set_cs() is a static 
function, not public? Manually controlling the slave-select seems like 
quite a common-place thing to do.

Best Regards
Joel Holdsworth
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
