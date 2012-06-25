From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH] spi: Unlock a spinlock before calling into the controller
	driver.
Date: Mon, 25 Jun 2012 10:07:35 -0700
Message-ID: <CAD=FV=UpBG8gmPjWDF0M9EMSvs4pg7icocMXJ1r3Lmi8frZsrg@mail.gmail.com>
References: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
	<CAOesGMgq5HRz+pDFQtED5GPN0RUrON=_k_y4YHHzKrMkHnVk4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: LinusW <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Freed <bfreed-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAOesGMgq5HRz+pDFQtED5GPN0RUrON=_k_y4YHHzKrMkHnVk4A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Olof,


On Sun, Jun 24, 2012 at 4:54 PM, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org> wrote:

> I'm not sure this is safe to do. The lock is dropped for the prepare
> side, but in that case we can be sure that the above code can't come
> in and unprepare at the same time since there is per definition a
> request on the queue at that time.


I spent a bunch of time staring at the code and I'm pretty sure that
there's no race and that the code is safe (if not super obvious).

Specifically there should be only one instance of spi_pump_messages()
running at a time per master. =A0That's because it's a kthread work
function. =A0...so we can't possibly get a prepare in the middle of the
unprepare when prepare is called because the only caller to
prepare/unprepare is spi_pump_messages().


I can't comment on whether it's better to do something like add=A0a
workqueue (which might be more obvious / less fragile) or just to add
a comment. =A0I will let others comment on that. =A0:)

-Doug

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
