From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: PATCH[V2 1/3]: Update Platform files for SPI
Date: Thu, 18 Feb 2010 09:28:58 -0700
Message-ID: <fa686aa41002180828l378a9550u125752e1e972a345@mail.gmail.com>
References: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
	<20100209222513.GJ21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Hemanth V <hemanthv@ti.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net
To: Tony Lindgren <tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100209222513.GJ21755@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 9, 2010 at 3:25 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Hemanth V <hemanthv@ti.com> [100203 02:19]:
>> From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2001
>> From: Hemanth V <hemanthv@ti.com>
>> Date: Fri, 27 Nov 2009 14:22:30 +0530
>> Subject: [PATCH] Update platform files
>>
>> This patch updates platform files for
>> fifo, slave support
>>
>> Signed-off-by: Hemanth V <hemanthv@ti.com>
>
> This should get merged via the spi-devel list with the other patches.
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Tony, do you want me to add your acked-by to patches 2 & 3?

Also, what is your feeling about patch 3/3, spi slave support.  spi
slave usage model is still a matter under debate, but that patch
doesn't touch core spi code, so I'm okay to merge it as a
driver-specific feature.  However, I'm not convinced that it is
actually a useful patch to merge yet, so I'll defer to you on this
one.  Thoughts?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
