From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 0/5] spi: spi-message transformation framework
Date: Wed, 9 Dec 2015 10:38:32 +0100
Message-ID: <5667F698.4040709@martin.sperl.org>
References: <1449501708-2228-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
 Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1449501708-2228-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 07.12.2015 16:21, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> This patchset implements a spi-message transformation framework in
> SPI-core, that allows drivers to transfor individual spi messages
> into something that can more easily get handled by the HW.
>
> This would typically be used for HW which has some limitations on
> DMA alignment or max transfer sizes.
>
> This patchset implements at this very moment only splitting
> transfers longer than 60k in size into multiple transfers.
>
> Future patches based on this basic patchset:
> * split misalligned transfers (there are probably multiple
>    variations necessary for different HW)
> * merge multiple small transfers into a single transfer
>
> The patch-set essentially is based arround spi resource
> management on a spi_message basis, which was inspired by
> devres.
>
> This framework could also get used to handle spi_unmap_buf
> calls with the framework.
>
> Right now the drivers themselves have to implement
> spi_master.translate_message, but as soon as the "typical"
> HW-variations become apparent this may be reduced to assign
> one of a set of "standard" translation methods to
> spi_master.translate_message instead, but this may require
> some additional parametrization of the HW characteristics.
>
> The whole patch set has been tested successfully on a RPI with:
> * spi_loopback_test
> * enc28j60
> * fb_st7735r - framebuffer playing BigBuckBunny
> * mmc-spi with an out of tree patch to work arround the mmc_spi
>    internal dma mapping issues, that inhibits the driver from working
>    correctly - this got introduced with commit 0589342c27944e50
>     ("of: set dma_mask to point to coherent_dma_mask")
>
> Martin Sperl (5):
>    spi: core: added spi_resource management
>    spi: core: add spi_replace_transfers method
>    spi: core: add spi_split_transfers_maxsize
>    spi: core add spi_master.translate_message
>    spi: bcm2835: make use of the spi_translate_message methods
>
>   drivers/spi/spi-bcm2835.c |   31 +++--
>   drivers/spi/spi.c         |  339 +++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/spi/spi.h   |   92 ++++++++++++
>   3 files changed, 448 insertions(+), 14 deletions(-)

Please note that Patch 1/5 (spi: core: added spi_resource management)
requires that method spi_message_init_no_memset exists(see patch-set
for spi-loopback-test) - this note did not make it into the description
of the second version of this patchset.

In the meantime I have implemented 2 more transformations:
* alignment of buffers (first spi_transfer.tx/rx_buf buffer
   remains unaligned, but has spi_transfer.len < alignment,
   second spi_transfer is fully alligned for rx/tx_buf with
   copying of tx_buf to make it alligned in the case where
   rx_buf and tx_buf are misaligned to different offsets)
* merging multiple tiny transfers

One code issue showed up (but that impacted only the new use-cases)
and there was a missing kerneldoc for one of the spi_statistics
members - these are 2 separate patches.

Should I send these separately or do you want a big patchset that
contains all of them?

Here the some of the statistics when running my spi-loopback-test:
==> /sys/class/spi_master/spi32766/statistics/transfers
1588
==> /sys/class/spi_master/spi32766/statistics/transfers_merged
102
==> /sys/class/spi_master/spi32766/statistics/transfers_split_maxsize
160
==> /sys/class/spi_master/spi32766/statistics/transfers_split_unaligned
372

Based on the above I am starting to think of readying a default
implementation for translation that drivers may use:

int spi_translate_message_size_align_merge(
         struct spi_master *master, struct spi_message *message)
{
         int ret;

         /* translate the message */

         /* fix alignment of transfers by splitting rx_buf/tx_buf
          * (and worsted case copying tx_buf)
          */
         ret = spi_split_transfers_unaligned(master, message,
                                             master->min_dma_len,
                                             master->dma_alignment);
         if (ret)
                 return ret;

         /* limit transfer length */
         if (master->max_dma_len) {
                 ret = spi_split_transfers_maxsize(master, message,
                                                   master->max_dma_len);
                 if (ret)
                         return ret;
         }

         /* merge spi_transfers up to a full page */
         ret = spi_merge_transfers(master, message, 2, PAGE_SIZE);

         return ret;
}

The spi_master driver would need to set these:
	master->translate_message =
		spi_translate_message_size_align_merge;
	master->min_dma_len = BCM2835_SPI_DMA_MIN_LENGTH;
	master->max_dma_len = 15 * PAGE_SIZE;
	master->dma_alignment = 4;

As seen above we would need to define a min_dma_len that can get used
as a parameter to align transfers (if a driver is doing PIO for short
transfers, then it makes no sense aligning them in the first place).

This value could also get used in a default implementation of can_dma.

Note that we could also expose min_dma_size via sysfs.
