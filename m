From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: what repo can I base patch works?
Date: Fri, 9 Jul 2010 09:56:40 -0600
Message-ID: <AANLkTil1rOzwgykIRHDLL9aw7IqJGA7zYWbPV-bl67F_@mail.gmail.com>
References: <AANLkTineorwtg3hSlb8-9-LlQpdMXLujNt0JhxG_p-N5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Kim, Heung Jun" <riverful-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTineorwtg3hSlb8-9-LlQpdMXLujNt0JhxG_p-N5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jul 9, 2010 at 9:15 AM, Kim, Heung Jun <riverful-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi everyone,
>
> I have a question.
>
> I found a spi_gpio framework issue need to be changed, so I =A0to make
> the patch based git://git.secretlab.ca/linux-2.6 next-spi.
> Is it right?? what repo can I base patch works?

Yes, you can either base your patch on next-spi or on against Linus'
tree.  If anything is sufficiently complex that it won't merge, then
I'll ask you to help me rebase it, but usually that isn't a problem.

Cheers,
g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
