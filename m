From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [RESEND] spi: davinci: Allow device tree devices to use DMA
Date: Thu, 12 Jan 2017 13:34:10 -0800
Message-ID: <m24m146jzh.fsf@baylibre.com>
References: <1483673177-31516-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Brown <broonie@kernel.org>, nsekhar@ti.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: David Lechner <david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1483673177-31516-1-git-send-email-david@lechnology.com> (David
        Lechner's message of "Thu, 5 Jan 2017 21:26:17 -0600")
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

David Lechner <david@lechnology.com> writes:

> This allows SPI devices specified in a device tree to use DMA when the
> master controller.

Enabling DMA for spi-davinci isn't quite ready yet since this driver is
blindly using dma_map_single() on addresses passed in.  MTD seems to use
vmalloc'd buffers, which cannot be passed direclty to dma_map_single().

I thinks this driver needs an update to use spi_map_buf() to be able to
handle vmalloc'd buffers before always enabling DMA.

Kevin
