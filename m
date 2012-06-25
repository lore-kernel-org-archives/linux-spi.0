From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Unlock a spinlock before calling into the controller
	driver.
Date: Tue, 26 Jun 2012 02:56:17 +0800
Message-ID: <CACRpkdbuiHmZP7HKuoaw1O0xyZJEDv6ja1Q=YqOtBViRYBufZQ@mail.gmail.com>
References: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
	<CAOesGMgq5HRz+pDFQtED5GPN0RUrON=_k_y4YHHzKrMkHnVk4A@mail.gmail.com>
	<CAD=FV=UpBG8gmPjWDF0M9EMSvs4pg7icocMXJ1r3Lmi8frZsrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bryan Freed <bfreed-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAD=FV=UpBG8gmPjWDF0M9EMSvs4pg7icocMXJ1r3Lmi8frZsrg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 26, 2012 at 1:07 AM, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrot=
e:

> Specifically there should be only one instance of spi_pump_messages()
> running at a time per master. =A0That's because it's a kthread work
> function. =A0...so we can't possibly get a prepare in the middle of the
> unprepare when prepare is called because the only caller to
> prepare/unprepare is spi_pump_messages().

Yes that's how the message pump is designed.

> I can't comment on whether it's better to do something like add=A0a
> workqueue (which might be more obvious / less fragile) or just to add
> a comment. =A0I will let others comment on that. =A0:)

The message pump initially used a workqueue, but was converted
to a kthread because we needed to push the queue to run as
realtime for some important low-latency workloads across
SPI. The code is basically a tweaked workqueue if you dive down
in the implementation.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
