From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: create a message queueing infrastructure
Date: Tue, 6 Mar 2012 13:26:46 +0100
Message-ID: <CACRpkdb4QWXpUcmVOX+1C3qSKNQ7GwrjE1ZuiKGVwG8mrgiWpQ@mail.gmail.com>
References: <1329901538-8644-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1329901538-8644-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 22, 2012 at 10:05 AM, Linus Walleij
<linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org> wrote:

> From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> This rips the message queue in the PL022 driver out and pushes
> it into (optional) common infrastructure. Drivers that want to
> use the message pumping thread will need to define the new
> per-messags transfer methods and leave the deprecated transfer()
> method as NULL.
>
> Most of the design is described in the documentation changes that
> are included in this patch.
>
> Since there is a queue that need to be stopped when the system
> is suspending/resuming, two new calls are implemented for the
> device drivers to call in their suspend()/resume() functions:
> spi_master_suspend() and spi_master_resume().
>
> ChangeLog v1->v2:
> - Remove Kconfig entry and do not make the queue support optional
> =A0at all, instead be more agressive and have it as part of the
> =A0compulsory infrastructure.
> - If the .transfer() method is implemented, delete print a small
> =A0deprecation notice and do not start the transfer pump.
> - Fix a bitrotted comment.
> ChangeLog v2->v3:
> - Fix up a problematic sequence courtesy of Chris Blair.
> - Stop rather than destroy the queue on suspend() courtesy of
> =A0Chris Blair.

Ping on this! Would be nice to see in linux-next if we go for this.

> Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

Mark can we have your explicit ACK?

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
