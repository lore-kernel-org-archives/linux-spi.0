From: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [git pull] SPI changes for v3.3-rc2
Date: Mon, 6 Feb 2012 15:34:37 -0800
Message-ID: <CA+55aFzbR2-_uAz-Rfc_OuK3NAj+PKyjKhDCMoHAwE7+jgmxQA@mail.gmail.com>
References: <CACxGe6uf6BpnHUFF7Svx_-C+ZGFop3T=TGGRi8kFQCgH56E4yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACxGe6uf6BpnHUFF7Svx_-C+ZGFop3T=TGGRi8kFQCgH56E4yA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Feb 5, 2012 at 10:28 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> w=
rote:
>
> A couple of minor SPI fixes. =A0Description in signed tag. =A0Please pull.

No can do. I get "already up-to-date".

It looks like the 'for-linus" tag is your *previous* one - you either
forgot to push, or you pushed without forcing an over-write and didn't
notice that git told you that it's not going to update a
non-fast-forward write or something.

Hmm?

Btw, exactly because problems sometimes happen, I do want to see the
description written out in the email too. The whole reason I want to
see diffstats and shortlogs is exactly because "it is correct in the
git tree" is not useful - the email should be a *confirmation* that
what I pulled from the git tree was really what you meant.

So saying "it's all there in the tag" is undermining the use of the
email as verification of the git tree update having gone correctly.

                      Linus

---------------------------------------------------------------------------=
---
Try before you buy =3D See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
