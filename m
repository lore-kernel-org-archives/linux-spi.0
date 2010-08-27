From: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi_tegra driver
Date: Fri, 27 Aug 2010 12:26:03 -0700
Message-ID: <AANLkTin4HxVLt=4VH-NQWhB-p_2EpX_yoTcwEOTJP3m_@mail.gmail.com>
References: <1280450224-25118-1-git-send-email-ccross@google.com>
	<1281574023-25160-1-git-send-email-konkers@android.com>
	<AANLkTim4nL+Re=qc55CGS+ksq+ACtGe=vqOeGQ3HbQWM@mail.gmail.com>
	<AANLkTincgapUK5ncs_t3ax=1Kt_56GdR_RVwRqdCm5ge@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ccross-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTincgapUK5ncs_t3ax=1Kt_56GdR_RVwRqdCm5ge-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 25, 2010 at 2:22 PM, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wrote:
>> As an aside, and commenting on the tegra DMA api... Is the IS_ERR()
>> pattern in the tegra_dma_allocate_channel() return really a good idea
>> here? =A0Personally I find that pattern isn't very useful, especially
>> when the results is either "yes, allocated" or "no, not-alocated", and
>> it is very easy to write code that tests the wrong thing on the return
>> value because the compiler cannot catch it. =A0In other words, if it
>> isn't vital to return a specific error code, the using the PTR_ERR()
>> pattern adds unnecessary risk to the code because developers are used
>> to seeing and writing this pattern:
>>
>> tspi->rx_dma =3D tegra_dma_allocate_channel(TEGRA_DMA_MODE_ONESHOT);
>> if (!tspi->rx_dma)
>> =A0 =A0 =A0 =A0return -ENOMEM;
>>
>> The compiler won't catch it if the return value is an PTR_ERR.
>>
>> (I know that some subsystems make heavy use of it, particularly
>> filesystems and the block layer which do need to return specific error
>> codes to userspace. =A0My argument is that the specific error code is
>> probably irrelevant when allocating DMA channels)
>
> I don't have a strong opinion either way but that's the way Colin's
> code is written. =A0I'll let him speak to that.

I spoke with colin about this.  He's fine getting rid of the PTR_ERR.
I'll post a DMA and SPI patch when that's done.

-Erik

---------------------------------------------------------------------------=
---
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users =

worldwide. Take advantage of special opportunities to increase revenue and =

speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
