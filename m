From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Add high priority message pump support
Date: Fri, 27 Jan 2012 08:43:14 -0700
Message-ID: <CACxGe6uzSh3-n0QNY-MX4UDkMirUJhDi3vMbB9=AWO-H7d_cMQ@mail.gmail.com>
References: <1327439672-638-1-git-send-email-linus.walleij@stericsson.com>
	<20120125140215.GB2054@sirena.org.uk>
	<CACRpkdauRqVzUbr59P75Zyd-AFc8Y7fBJ=AWoSMQPYxXUJjBMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACRpkdauRqVzUbr59P75Zyd-AFc8Y7fBJ=AWoSMQPYxXUJjBMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 26, 2012 at 7:48 AM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Jan 25, 2012 at 3:02 PM, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:
>> On Tue, Jan 24, 2012 at 10:14:32PM +0100, Linus Walleij wrote:
>
>>> This switches the PL022 worker to a kthread in order to get
>>> hold of a mechanism to control the message pump priority. On
>>> low-latency systems elevating the message kthread to realtime
>>> priority give a real sleek response curve. This has been
>>> confirmed by measurements. Realtime priority elevation for
>>> a certain PL022 port can be requested from platform data.
>>
>> It really feels like we should be pulling this into the core - lots of
>> drivers use a workqueue to drive data through the system and they're all
>> going to have exactly the same issue.
>
> That reads to me like the entire message queue and "transfer pump"
> mechanism from the PL022 driver should be made into generic
> code. That is the key ingredient from the PL022 driver that has
> allowed us to get real nice throughput on it.
>
> And that observation is correct, but a bit of upfront code.
>
> If Grant is in on it I might give it a try.

Go for it and see what it looks like.

g.

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
