From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] Blackfin SPI Driver: Make mmc_spi driver work on
 Blackfin
Date: Thu, 5 Feb 2009 14:13:02 -0800
Message-ID: <20090205141302.be8b3217.akpm@linux-foundation.org>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
	<1233828453-13311-6-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, wolfgang.mues@auerswald.de,
	yi.li@analog.com, cooloney@kernel.org
To: Bryan Wu <cooloney@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755168AbZBEWOM@vger.kernel.org>
In-Reply-To: <1233828453-13311-6-git-send-email-cooloney@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu,  5 Feb 2009 18:07:33 +0800
Bryan Wu <cooloney@kernel.org> wrote:

> 1. Rewrite of the non-dma data transfer functions to use only ONE
> mode of TIMOD (TIMOD=0x1). With TIMOD=0, it was not possible to set
> the TX bit pattern. So the TDBR = 0xFFFF inside the read calls won't
> work.
> 
> 2. Clear SPI_RDBR before reading and before duplex transfer. Otherwise
> the garbage data in RDBR will get read. Since mmc_spi uses a lot of
> duplex transfers, this is the main cause of mmc_spi failure.
> 
> 3. Poll RXS for transfer completion. Polling SPIF or TXS cannot
> guarantee transfer completion. This may interrupt a transfer before
> it is finished. Also this may leave garbage data in buffer and
> affect next transfer.
> 
> [Yi Li <yi.li@analog.com>: add a field "u16 idle_tx_val" in "struct
> bfin5xx_spi_chip" to specify the value to transmit if no TX value
> is supplied.]


again, driver-core has destroyed your patch.

There was no _need_ to take the unusual and undesirable step of
modifying SPI via an unrelated tree.
