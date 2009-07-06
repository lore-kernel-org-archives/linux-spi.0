From: "Hemanth V" <hemanthv@ti.com>
Subject: Re: [RESEND][PATCH 0/2] McSPI Slave and DMA ,FIFO support
Date: Mon, 6 Jul 2009 12:17:20 +0530
Message-ID: <007b01c9fe05$9e5baeb0$LocalHost@wipultra793>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com> <200907021705.18048.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <linux-omap@vger.kernel.org>,
	<spi-devel-general@lists.sourceforge.net>
To: "David Brownell" <david-b@pacbell.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

----- Original Message ----- 
From: "David Brownell" <david-b@pacbell.net>


> On Tuesday 23 June 2009, Hemanth V wrote:
>> This series of 2 patches adds support for McSPI slave
>> and DMA,FIFO. It incorporates review comments from
>> Kevin Hilman and Tony Lindgren
>> 
>> 
>> PATCH[1/2]: Changes to arch specific files
>> PATCH[2/2]: omap2_mcspi.c file changes
> 
> Needs some changes yet:
> 
>  - Split out slave support as a separate patch.
>    That's not really supported by the interface yet.

Do you see any major changes required to support
slave mode in the SPI core driver. We are able to
use the existing interface for slave mode also, but
some APIs/ Structures could be made generic.


