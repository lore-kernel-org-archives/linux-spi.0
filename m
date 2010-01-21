From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 4/6] SPI: S3C64XX: Check before
	mem-region release
Date: Wed, 20 Jan 2010 19:55:16 -0700
Message-ID: <fa686aa41001201855m5c054d90nb3652a5b0d3ffd86@mail.gmail.com>
References: <1263808215-16544-1-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-2-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-3-git-send-email-jassisinghbrar@gmail.com>
	<1263808215-16544-4-git-send-email-jassisinghbrar@gmail.com>
	<fa686aa41001181012s57c0e863s6b9b6b2724514a9f@mail.gmail.com>
	<1b68c6791001181542p618a8d47n45a120e51cfed1f1@mail.gmail.com>
	<fa686aa41001181832r3d2462f6y87649244b8afc5f2@mail.gmail.com>
	<1b68c6791001190152m652fd117k468893144af8dcfe@mail.gmail.com>
	<1b68c6791001201735w3060c54blfa85b547917727c2@mail.gmail.com>
	<1b68c6791001201746p313234bbkdf5fe5db0dcecd9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ben-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org
To: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1b68c6791001201746p313234bbkdf5fe5db0dcecd9f-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 20, 2010 at 6:46 PM, jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrot=
e:
> On Thu, Jan 21, 2010 at 10:35 AM, jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>> Hi Grant Likely,
>> =A0You have reviewed this series of patches but didn't ACK/NAK.
>> Could you kindly confirm if u accept them or want some changes?
>> Thanks.
> Nevermind, I just saw ur ACK at my official ID (many maintainers reply
> something like
> 'pulled now' to the patch thread but thats ok if you ACK personally).
> Thanks.

I'm using patchwork.kernel.org for collecting spi patches.
Unfortunately patchwork doesn't provide any mechanism for emailing
"merged" messages when I accept patches.  To compensate, I've started
cc'ing patch authors my next- branch update message when I push out an
updated tree.

You can also always look at patchwork.kernel.org to see if your
patches are still in the queue.  I won't forget accidentally drop any
patches tracked by patchwork.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Confere=
nce
attendees to learn about information security's most important issues throu=
gh
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
