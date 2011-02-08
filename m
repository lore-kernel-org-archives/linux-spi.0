From: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v1] davinci: spi: move event queue parameter to platform
	data
Date: Tue, 8 Feb 2011 13:23:58 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59302488B9AFA@dbde02.ent.ti.com>
References: <1296828552-11765-1-git-send-email-michael.williamson@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org" <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	"dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1296828552-11765-1-git-send-email-michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Feb 04, 2011 at 19:39:12, Michael Williamson wrote:
> For DMA operation, the davinci spi driver needs an event queue number.
> Currently, this number is passed as a IORESOURCE_DMA.  This is not
> correct, as the event queue is not a DMA channel.  Pass the event queue
> via the platform data structure instead.
> 
> On dm355 and dm365, move the eventq assignment for spi0 out of resources
> array and into platform data.
> 
> Signed-off-by: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>

Tested this on DM355 and DM365 EVMs. Event queue numbers show up
properly in the logs and DMA transfers to on-board SPI EEPROMs
happen correctly.

> ---
> Changes since v0:
>   - combined separate platform patches with driver patch to avoid
>     potential regression if doing a bissect.
>   - fixed up typo per comments.

This typo doesn't seem fixed?

> + * @dma_event_q: DMA event_q to use if SPI_IO_TYPE_DMA is used for any device
> + *		on the bus.

On 2/4/2011 7:03 AM, Sergei Shtylyov wrote:
>> + * @dma_event_q: DMA event_q to use if SPI_IO_TYPE_DMA is used for any device
> 
>    s/event_q/event queue/?

Can you please re-spin with this fixed and my ack included:

Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

With Grant's ack this should probably get merged through
DaVinci tree (since it touches mach-davinci).

Thanks,
Sekhar


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
