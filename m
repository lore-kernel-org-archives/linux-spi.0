From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_spi: fix dma addr calculation for len >
 BUFFER_SIZE
Date: Mon, 28 Sep 2009 09:12:59 +0200
Message-ID: <20090928091259.27485716@hskinnemoen-d830>
References: <1254029187.7587.146.camel@ben-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: hskinnemoen@atmel.com, spi-devel-general@lists.sourceforge.net,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	kernel <kernel@avr32linux.org>, dbrownell@users.sourceforge.net
To: Ben Nizette <bn@niasdigital.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752466AbZI1HNg@vger.kernel.org>
In-Reply-To: <1254029187.7587.146.camel@ben-desktop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Ben Nizette <bn@niasdigital.com> wrote:
> If len > BUFFER_LEN and !xfer->rx_buf we end up calculating the tx
> buffer address as
> 
> *tx_dma = xfer->tx_dma + xfer->len - BUFFER_SIZE;
> 
> which is constant; i.e. we just send the last BUFFER_SIZE data over
> again until we've reached the right number of bytes.
> 
> This patch gets around this by using the /requested/ length when
> calculating addresses.
> 
> Note there's no way len != *plen when we calculate the rx buffer address
> but conceptually we should be using *plen and I don't want someone to
> come through later, see the calculations for rx and tx are different and
> "clean up" back to what we had.
> 
> Signed-off-by: Ben Nizette <bn@niasdigital.com>

Wow, that is subtle. I had to stare at it for a long while before I
understood what's going on, but I believe you're right.

Acked-by: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>

While you're at it, could you send another patch renaming 'len' to
'next_len'? I think that would make it a bit more obvious why your
patch is correct and prevent similar mistakes in the future.

Haavard
