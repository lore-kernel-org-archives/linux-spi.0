From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] [PATCH v6] Add Dallas DS1390/93/94 RTC chips
Date: Thu, 6 Nov 2008 18:42:46 +0100
Message-ID: <20081106184246.53950fa0@i1501.lan.towertech.it>
References: <4912B459.2020704@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: mpfj@mimc.co.uk, dbrownell@users.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
To: rtc-linux@googlegroups.com
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751118AbYKFRnI@vger.kernel.org>
In-Reply-To: <4912B459.2020704@mimc.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 06 Nov 2008 09:09:45 +0000
Mark Jackson <mpfj@mimc.co.uk> wrote:

> v6 (!!) of this patch with even more code tidying as per previous comments.

 I know.. I'm becoming stricter and stricter as the time goes by.. 

> Also only a single tx/rx buffer is used.
> Now uses spi_write_then_read()
> Comments changed to include extra chips in the family
> 
> This patch adds support for the Dallas DS1390/93/94 SPI RTC chip.

 There's still one printk left that you can avoid :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
