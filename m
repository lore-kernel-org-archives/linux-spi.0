From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [GIT PULL] SPI bug fixes for v3.8 merge window
Date: Thu, 20 Dec 2012 00:52:07 +0000
Message-ID: <CACxGe6sb3exTgYeryOt4RBGPEBnRzWa=PpiHuKBf296bq1HS9w@mail.gmail.com>
References: <CACxGe6vziasGs8cuatkniPVSJ4sst-EcPBEAaKeHDoKfqk4mbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACxGe6vziasGs8cuatkniPVSJ4sst-EcPBEAaKeHDoKfqk4mbQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

[Forgot to cc: lkml]

On Thu, Dec 20, 2012 at 12:46 AM, Grant Likely
<grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> Hi Linus,
>
> And finally, here are the bug fixes I've queued up for SPI. Very
> little in the way of excitement other than a device driver feature
> that should have been in my first pull req, but I missed it. It should
> be low risk, but if it bothers you then I can respin without it.
>
> And now I'm off to bed.
>
> g.
>
> The following changes since commit 4939e27d46fee2609f2112f85f7f7cbd952075dc:
>
>   Merge tag 'devicetree-for-linus' of
> git://git.secretlab.ca/git/linux-2.6 (2012-12-14 15:37:46 -0800)
>
> are available in the git repository at:
>
>
>   git://git.secretlab.ca/git/linux-2.6 tags/spi-for-linus
>
> for you to fetch changes up to d3601e56cf64a3f2df6f6380cccb3644274406e2:
>
>   spi/sh-hspi: fix return value check in hspi_probe(). (2012-12-19
> 15:11:41 +0000)
>
> ----------------------------------------------------------------
> SPI device driver bug fixes branch for the v3.8 merge window. Most of
> this is bug fixes to the core code and the sh-hspi and s3c64xx device
> drivers.
>
> There is also a patch here to add DT support to the Atmel driver. This
> one should have been in the first round, but I missed it. It's a low
> risk change contained within a single driver and the Atmel maintainer
> has requested it.
>
> ----------------------------------------------------------------
> Allen Martin (1):
>       spi: fix tegra SPI binding examples
>
> Cyril Roelandt (1):
>       spi/sh-hspi: fix return value check in hspi_probe().
>
> David Daney (1):
>       of/spi: Fix SPI module loading by using proper "spi:" modalias prefixes.
>
> Jean-Christophe PLAGNIOL-VILLARD (1):
>       spi/atmel: add DT support
>
> Kyoungil Kim (2):
>       spi: Keep chipselect assertion during one message
>       spi: Change FIFO flush operation and spi channel off
>
>  .../bindings/spi/nvidia,tegra20-sflash.txt         |    2 +-
>  .../bindings/spi/nvidia,tegra20-slink.txt          |    2 +-
>  .../devicetree/bindings/spi/spi_atmel.txt          |   26 ++++++++++++++++++++
>  drivers/spi/spi-atmel.c                            |   17 ++++++++++++-
>  drivers/spi/spi-s3c64xx.c                          |   10 +++-----
>  drivers/spi/spi-sh-hspi.c                          |    2 +-
>  drivers/spi/spi.c                                  |    5 +++-
>  7 files changed, 53 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi_atmel.txt
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.



--
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
