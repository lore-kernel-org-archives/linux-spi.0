From: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: linux-next: Tree for Sep 16 (spi/spi-bcm-qspi.c)
Date: Fri, 16 Sep 2016 09:26:25 -0700
Message-ID: <d7ab4275-bc93-94f3-ab26-4ff5649ad0fb@infradead.org>
References: <20160916144547.7ea03f37@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160916144547.7ea03f37-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/15/16 21:45, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20160915:
> 

on i386:

when CONFIG_PM_SLEEP and CONFIG_SUSPEND are not enabled:

../drivers/spi/spi-bcm-qspi.c:1300:13: error: 'bcm_qspi_suspend' undeclared here (not in a function)
  .suspend = bcm_qspi_suspend,
             ^
../drivers/spi/spi-bcm-qspi.c:1301:13: error: 'bcm_qspi_resume' undeclared here (not in a function)
  .resume  = bcm_qspi_resume,
             ^



-- 
~Randy
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
