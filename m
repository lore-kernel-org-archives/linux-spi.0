From: Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: mediatek: Only do dma for 4-byte aligned buffers
Date: Thu, 26 Jan 2017 08:42:20 -0800
Message-ID: <CAE_wzQ_kC4nc28VU-msZkMAnChtkY6uWiSWFv8x4BHh3B7RJXA@mail.gmail.com>
References: <20170126162154.124287-1-djkurtz@chromium.org>
 <20170126162154.124287-2-djkurtz@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: drinkcat-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
 Dmitry Torokhov <dtor-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 Guenter Roeck <groeck-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>,
 "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20170126162154.124287-2-djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Daniel,

On Thu, Jan 26, 2017 at 8:21 AM, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> Mediatek SPI DMA only works when tx and rx buffer addresses are 4-byte
> aligned.
>
> Unaligned DMA transactions appeared to work previously, since we the
> spi core was incorrectly using the spi_master device for dma, which
> had a 0 dma_mask, and therefore the swiotlb dma map operations were
> falling back to using bounce buffers.  Since each DMA transaction would
> use its own buffer, the mapped starting address of each transaction was
> always aligned.  When doing real DMA, the mapped address will share the
> alignment of the raw tx/rx buffer provided by the SPI user, which may or
> may not be aligned.
>
> If a buffer is not aligned, we cannot use DMA, and must use FIFO based
> transaction instead.

>From spi.h:

/**
 * struct spi_transfer - a read/write buffer pair
 * @tx_buf: data to be written (dma-safe memory), or NULL
 * @rx_buf: data to be read (dma-safe memory), or NULL

DMA-safe memory is ___cacheline_aligned, so it appears to be user (of
the SPI) error providing "bad" memory for transfers.

Thanks,
Dmitry
