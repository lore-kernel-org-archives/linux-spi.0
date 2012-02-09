From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [git pull] SPI changes for v3.3-rc2
Date: Wed, 8 Feb 2012 16:52:16 -0800
Message-ID: <CACxGe6sRHg3txoxcBLDUVLFfjXOCYAGOk+Cou=a7teJR0qtC1w@mail.gmail.com>
References: <CACxGe6uf6BpnHUFF7Svx_-C+ZGFop3T=TGGRi8kFQCgH56E4yA@mail.gmail.com>
	<CA+55aFzbR2-_uAz-Rfc_OuK3NAj+PKyjKhDCMoHAwE7+jgmxQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+55aFzbR2-_uAz-Rfc_OuK3NAj+PKyjKhDCMoHAwE7+jgmxQA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 6, 2012 at 3:34 PM, Linus Torvalds
<torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:
> On Sun, Feb 5, 2012 at 10:28 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>=
 wrote:
>>
>> A couple of minor SPI fixes. =A0Description in signed tag. =A0Please pul=
l.
>
> No can do. I get "already up-to-date".
>
> It looks like the 'for-linus" tag is your *previous* one - you either
> forgot to push, or you pushed without forcing an over-write and didn't
> notice that git told you that it's not going to update a
> non-fast-forward write or something.
>
> Hmm?

It looks like the branch got pushed, but not the tag.  Fixed now.
Below is the updated pull request.

> Btw, exactly because problems sometimes happen, I do want to see the
> description written out in the email too. The whole reason I want to
> see diffstats and shortlogs is exactly because "it is correct in the
> git tree" is not useful - the email should be a *confirmation* that
> what I pulled from the git tree was really what you meant.

Okay.  Will do.

g.

---

SPI bug fixes for v3.3-rc2

Minor SPI device driver changes.  A rename of the pch_spi_pcidev symbol
that merely eliminates a modpost warning, and a Kconfig change to allow
the Samsung spi driver to build on EXYNOS.

The following changes since commit e862f2e4693f287669e84971c778bf071bd0526b:

  Merge tag 'sound-fixes' of
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2012-02-08
14:56:39 -0800)

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6 spi-for-linus

Danny Kukawka (1):
      spi-topcliff-pch: rename pch_spi_pcidev to pch_spi_pcidev_driver

Sylwester Nawrocki (1):
      spi: Add spi-s3c64xx driver dependency on ARCH_EXYNOS4

 drivers/spi/Kconfig            |    2 +-
 drivers/spi/spi-topcliff-pch.c |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

---------------------------------------------------------------------------=
---
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing =

also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
