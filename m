From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v1] eSPI: add Aspeed AST2500 eSPI driver to boot a host
 with PCH runs on eSPI
Date: Sun, 31 Dec 2017 00:10:51 +0100
Message-ID: <CAK8P3a2nZzc22FgupGjGeS7uQkrxH_W7=T7m_foejDMHtp70_w@mail.gmail.com>
References: <1514512387-27113-1-git-send-email-haiyue.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Joel Stanley <joel-U3u1mxZcP9KHXe+LvDLADg@public.gmane.org>, gregkh <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Haiyue Wang <haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1514512387-27113-1-git-send-email-haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Dec 29, 2017 at 2:53 AM, Haiyue Wang
<haiyue.wang-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> When PCH works under eSPI mode, the PMC (Power Management Controller) in
> PCH is waiting for SUS_ACK from BMC after it alerts SUS_WARN. It is in
> dead loop if no SUS_ACK assert. This is the basic requirement for the BMC
> works as eSPI slave.
>
> Also for the host power on / off actions, from BMC side, the following VW
> (Virtual Wire) messages are done in firmware:
> 1. SLAVE_BOOT_LOAD_DONE / SLAVE_BOOT_LOAD_STATUS
> 2. SUS_ACK
> 3. OOB_RESET_ACK
> 4. HOST_RESET_ACK

I have not looked at the driver contents yet, but I'm adding the SPI
maintainer and
mailing list to Cc here for further discussion. Can you clarify how
the eSPI slave
mode relates to SPI slaves that we already support? I was under the impression
that the difference between SPI and eSPI is mainly on the master side, but that
any SPI slave can also act as an eSPI slave. Would this driver fit into the SPI
slave framework, possibly with some extensions to the generic abstraction?

It also seems rather inflexible to have a single driver that is responsible both
for the transport (eSPI register level interface for ASPEED) and the high-level
protocol (talking to an Intel PCH), since either half of the work could be
done elsewhere, using either a different eSPI slave implementation, or
a different
host architecture)

       Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
