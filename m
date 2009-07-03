From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND][PATCH 0/2] McSPI Slave and DMA ,FIFO support
Date: Thu, 2 Jul 2009 17:05:17 -0700
Message-ID: <200907021705.18048.david-b@pacbell.net>
References: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-omap@vger.kernel.org, spi-devel-general@lists.sourceforge.net
To: "Hemanth V" <hemanthv@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <42120.10.24.255.18.1245765231.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 23 June 2009, Hemanth V wrote:
> This series of 2 patches adds support for McSPI slave
> and DMA,FIFO. It incorporates review comments from
> Kevin Hilman and Tony Lindgren
> 
> 
> PATCH[1/2]: Changes to arch specific files
> PATCH[2/2]: omap2_mcspi.c file changes

Needs some changes yet:

  - Split out slave support as a separate patch.
    That's not really supported by the interface yet.

  - You sent the two patches with the same $SUBJECT;
    which indicates they are the *SAME* patch ...
    either make it be one patch, or change $SUBJECT
    (perhaps to match what you used above).

The stuff in #1 should have Tony's ack.


> 
>  arch/arm/mach-omap2/devices.c           |    5
>  arch/arm/plat-omap/include/mach/mcspi.h |   16 +
>  drivers/spi/omap2_mcspi.c               |  353
> ++++++++++++++++++++++++++++++++++++++++------
> 
> 
> 


