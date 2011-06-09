From: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Moorestown SPI
Date: Thu, 9 Jun 2011 11:46:08 +0530
Message-ID: <BANLkTi=opnmBxKYbXyGMD72qWF5wtqNeeA@mail.gmail.com>
References: <BANLkTikaHBL_+_vCc=ow2E9QzWK-58Pq0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BANLkTikaHBL_+_vCc=ow2E9QzWK-58Pq0Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Everyone,

Has anybody noticed such issues?
Or is there something wrong with my protocol driver...
any pointers will be really helpful.

Regards,
Tom

On Fri, May 27, 2011 at 8:22 PM, Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> The MRST dw_spi in Transmit & receive mode running on kernel 2.6.35,
> stepping A3, is unable to receive data properly.
> The slave is sending the data as expected, but the spi controller is not
> reading it properly.
>
> If i insert the messages or the delay equivalent as shown below it works.
> Any clue ?
>
> static int u8_writer(struct dw_spi *dws)
> {
> if (!(dw_readw(dws, sr) & SR_TF_NOT_FULL)
>  || (dws->tx == dws->tx_end))
> return 0;
>
> dw_writew(dws, dr, *(u8 *)(dws->tx));
>  // printk("dw write %x ",*(u8 *)(dws->tx));
>  udelay(50);
> ++dws->tx;
>
> wait_till_not_busy(dws);
> return 1;
> }
>
> static int u8_reader(struct dw_spi *dws)
> {//printk("dw spi %s ",__func__);
> while ((dw_readw(dws, sr) & SR_RF_NOT_EMPT)
>  && (dws->rx < dws->rx_end)) {
> *(u8 *)(dws->rx) = dw_readw(dws, dr);
>  // printk("dw read %x ",*(u8 *)(dws->rx));
> udelay(50);
>  ++dws->rx;
> }
>
> wait_till_not_busy(dws);
>  return dws->rx == dws->rx_end;
> }
>
------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
