From: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Subject: Re: atmel_spi: DMA-imposed xfer buffer
	requirements
Date: Mon, 20 Oct 2008 18:02:48 +0100
Message-ID: <20081020170248.GB14806@trinity.fluff.org>
References: <106f03a70810200856q4af97370h6cd456f3a42d70e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Andrei Rylin <port777-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <106f03a70810200856q4af97370h6cd456f3a42d70e5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 20, 2008 at 08:56:41AM -0700, Andrei Rylin wrote:
> Haavard,
> thanks for clarification about cs_change.
> I have another (hopefully last) question about atmel_spi driver.
> atmel_spi driver DMA-maps the buffers pointed to by spi_transfer.
> What are alignment and size requirements for the buffers ?
> How to expressed them in a platform-independent way,
> i.e. suitable for use with other SPI master drivers ?
> Can the buffers be in stack ? Or do they always have to be
> allocated from a non-paged pool ?

no, I belive no linux arch allows dma to/from the stack.

dma_alloc_xxx() and friends are your best bet for allocating such
memory.

> Thanks,
> Andrei.
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
