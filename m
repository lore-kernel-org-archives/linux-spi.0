From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 1/1] davinci: spi: replace
	existing driver
Date: Thu, 8 Jul 2010 13:34:02 -0600
Message-ID: <AANLkTil95LqvKmYP50i8XPQM20HcedZOtWAtPWUIeJ8N@mail.gmail.com>
References: <1278617003-10295-1-git-send-email-bniebuhr@efjohnson.com>
	<1278617003-10295-2-git-send-email-bniebuhr@efjohnson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1278617003-10295-2-git-send-email-bniebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 8, 2010 at 1:23 PM, Brian Niebuhr <bniebuhr3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> INTRODUCTION
>
> I have been working on a custom OMAP-L138 board that has multiple spi
> devices (seven) on one controller. =A0These devices have a wide range of
> transfer parameters (speed, phase, polarity, internal and gpio chip
> selects). =A0During my testing I found multiple errors in the davinci spi
> driver as a result of this complex setup. =A0The primary issues were:

Nack.  Sorry for being abrupt, but the patch still is full of
unrelated whitespace changes (tabs converted to spaces) which makes
the patch very difficult to review.  This needs to be fixed.

Let me know if you need help with how to do this.

g.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
