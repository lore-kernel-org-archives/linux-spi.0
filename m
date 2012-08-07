From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH] spi: omap2-mcspi: In case of dma errors fall back to
 pio
Date: Tue, 07 Aug 2012 16:51:16 +0530
Message-ID: <5020FA2C.2020707@ti.com>
References: <1343197229-15188-1-git-send-email-shubhrajyoti@ti.com> <20120807074740.GR11011@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120807074740.GR11011@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 07 August 2012 01:17 PM, Tony Lindgren wrote:
>>  };
> Don't you need to check separately for rx and tx dma? There's a slight
> chance that you get a channel for one but not for the other..
In that case I treat it as non usable and fall back to pio.

Are you suggesting that let one channel be dma and only the failed one pio?
