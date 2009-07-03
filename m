From: David Brownell <david-b@pacbell.net>
Subject: Re: [RESEND][PATCH 2/2] McSPI Slave and DMA,FIFO support
Date: Thu, 2 Jul 2009 17:22:02 -0700
Message-ID: <200907021722.02459.david-b@pacbell.net>
References: <42150.10.24.255.18.1245765248.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
To: "Hemanth V" <hemanthv@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <42150.10.24.255.18.1245765248.squirrel@dbdmail.itg.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 23 June 2009, Hemanth V wrote:
> This patch adds support for McSPI slave and FIFO. DMA and FIFO
> could be enabled together for better throughput.
> 
> This has a dependency on patch
> [RESEND][PATCH 1/2] McSPI Slave and DMA,FIFO support

... in this case I'd think they would better be part of
a single patch.

However, anything related to SPI slave support should
be separated entirely from FIFO support.

Ditto anything adding more SPI_DEBUG support.

Oh, and use the BIT(n) syntax not (1 << n) in the new
constants you define... the patch making this driver
use that style finally went upstream.


