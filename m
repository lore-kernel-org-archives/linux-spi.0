From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: pxa2xx: Remove rx_/tx_map_len members from struct driver_data
Date: Wed, 23 Mar 2016 19:16:41 +0100
Message-ID: <87bn65rree.fsf@belgarion.home>
References: <1458746964-9335-1-git-send-email-jarkko.nikula@linux.intel.com>
	<1458746964-9335-2-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458746964-9335-2-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
	(Jarkko Nikula's message of "Wed, 23 Mar 2016 17:29:23 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> spi-pxa2xx-dma.c DMA engine implementation stopped using PIO for
> unaligned trailing bytes in the commit 111e0a9dc71e ("spi/pxa2xx: Prevent
> DMA from transferring too many bytes"). This means there is no need to
> update tx/rx transfer buffer pointers after DMA completion. These buffer
> pointers will be set to new buffers when handling the next transfer.
>
> Because this buffer pointer update was only remaining use for rx_map_len
> and tx_map_len members in struct driver_data after removing the legacy PXA
> DMA implementation they can be removed now.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

--
Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
