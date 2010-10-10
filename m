From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v4] spi: add spi_tegra driver
Date: Sun, 10 Oct 2010 00:31:18 -0600
Message-ID: <AANLkTini_PA3J+R4gEP4DzFpcAxHhdmDbcXxOtj2h81O@mail.gmail.com>
References: <1282771395-21684-1-git-send-email-konkers@android.com>
	<1283379393-14831-1-git-send-email-konkers@android.com>
	<AANLkTimonLa1mUVSHR=QnR48HPtAZ5BW3BsVsg7MWALy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimonLa1mUVSHR=QnR48HPtAZ5BW3BsVsg7MWALy-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 2, 2010 at 8:22 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wr=
ote:
> On Wed, Sep 1, 2010 at 4:16 PM, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org> wrote:
>> v2 changes:
>> =A0from Thierry Reding:
>> =A0 =A0* add "select TEGRA_SYSTEM_DMA" to Kconfig
>> =A0from Grant Likely:
>> =A0 =A0* add oneline description to header
>> =A0 =A0* inline references to DRIVER_NAME
>> =A0 =A0* inline references to BUSY_TIMEOUT
>> =A0 =A0* open coded bytes_per_word()
>> =A0 =A0* spi_readl/writel -> spi_tegra_readl/writel
>> =A0 =A0* move transfer validation to spi_tegra_transfer
>> =A0 =A0* don't request_mem_region iomem as platform bus does that for us
>> =A0 =A0* __exit -> __devexit
>>
>> v3 changes:
>> =A0from Russell King:
>> =A0 =A0* put request_mem_region back int
>> =A0from Grant Likely:
>> =A0 =A0* remove #undef DEBUG
>> =A0 =A0* add SLINK_ to register bit defines
>> =A0 =A0* remove unused bytes_per_word
>> =A0 =A0* make spi_tegra_readl/writel static linine
>> =A0 =A0* various refactoring for clarity
>> =A0 =A0* mark err if BSY bit is not cleared after 1000 retries
>> =A0 =A0* move spinlock to protect setting of RDY bit
>> =A0 =A0* subsys_initcall -> module_init
>>
>> v3 changes:
>> =A0from Grant Likely:
>> =A0 =A0* update spi_tegra to use PTR_ERRless dma API
>>
>> Signed-off-by: Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>
>> Cc: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
>> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>> Cc: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>
> Hi Erik,
>
> Go ahead and add my Acked-by line and merge this via the tegra tree to
> avoid ordering issues. =A0I also have a few more minor comments below.

Hi Erik,

What's the status on this one?  I've not seen it show up in the
for-next branch of the android tegra tree.

g.

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
