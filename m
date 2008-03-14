From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Interpretation of SPI debug output
Date: Fri, 14 Mar 2008 17:11:06 +0100
Message-ID: <20080314171106.46a3c97a@hskinnemo-gx620.norway.atmel.com>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA33LEMKcTz06k3l6K9b/SmcKAAAAQAAAA3GVhRjpIl0iO5gj+NVEuJgEAAAAA@singnet.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: cksim-rdc5FV7LBygPGFelY5Zqew@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA33LEMKcTz06k3l6K9b/SmcKAAAAQAAAA3GVhRjpIl0iO5gj+NVEuJgEAAAAA-rdc5FV7LBygPGFelY5Zqew@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 14 Mar 2008 21:34:14 +0800
"CK Sim" <cksim-rdc5FV7LBygPGFelY5Zqew@public.gmane.org> wrote:

> Can anyone help to give a brief description on how to interpret the first
> statement, especially "tx c02eb3b5/202eb3b5 rx c02eb3b7/202eb3b7" ?

Read the source ;-)

                dev_dbg(controller,
                        "  xfer %p: len %u tx %p/%08x rx %p/%08x\n",
                        xfer, xfer->len,
                        xfer->tx_buf, xfer->tx_dma,
                        xfer->rx_buf, xfer->rx_dma);

It's the virtual/physical addresses of the tx and rx buffers.

Haavard

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
