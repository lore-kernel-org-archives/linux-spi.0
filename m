From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] atmel_spi: fix dma addr calculation
 for len > BUFFER_SIZE
Date: Tue, 29 Sep 2009 08:57:51 +0200
Message-ID: <20090929085751.3cc1fa3c@hskinnemoen-d830>
References: <1254029187.7587.146.camel@ben-desktop>
	<20090928091259.27485716@hskinnemoen-d830>
	<1254185759.7587.180.camel@ben-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	kernel <kernel-o2ulR9ObcgE/ohRxsw7f2g@public.gmane.org>,
	Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1254185759.7587.180.camel@ben-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org> wrote:
> From: Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org>
> Subject: [PATCH] atmel_spi: make "len" variable name less ambiguous in dma addr calculation
> 
> "[PATCH] atmel_spi: fix dma addr calculation for len > BUFFER_SIZE"
> fixed a bug where the "len" variable in atmel_spi_next_xfer_data() was
> taken to be the total number of bytes remaining in the transfer but it
> actually represents the number of bytes which will be sent this dma
> chunk.  While the 2 will be the same if there is less than 1 chunk to go
> (or if we aren't using a scratch buffer and therefore aren't breaking
> the transfers in to chunks), they won't be the same in general.
> 
> s/len/next_len to reflect the true nature and usage of this variable.
> 
> Signed-off-by: Ben Nizette <bn-pV1zxKMKwgg3AZtZ2NlBNQ@public.gmane.org>

Excellent, thanks.

Acked-by: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
