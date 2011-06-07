From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Tue, 7 Jun 2011 00:36:38 -0400
Message-ID: <BANLkTik0rS18wCbzkDqarvmwrEY5vLGp0A@mail.gmail.com>
References: <20110606071829.10334.90865.stgit@ponder> <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
 <BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com> <4DED0510.1030600@gmail.com>
 <BANLkTi=s2pnANPS5ZhjM9ZW8Bctk2v3DLw@mail.gmail.com> <4DEDA9C9.6000109@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Grant Likely <grant.likely@secretlab.ca>,
	Dirk Brandewie <dirk.brandewie@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DEDA9C9.6000109@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 7, 2011 at 00:32, Tomoya MORINAGA wrote:
> (2011/06/07 1:52), Grant Likely wrote:
>> Hahaha. =C2=A0Oops, I can't remember the conversation I had 5 minute=
s after
>> getting off the phone.
>>
>> It should actually be Tomoya who can comment on the name change.
>
> As far as I know, this change doesn't occur any issue.
> However, I don't have perfect confidence about it.
> Could you give me any information about concern ?

KBUILD_MODNAME is automatically expanded from the file name.  so any
code using KBUILD_MODNAME cannot be renamed with 0 side effects.  the
question is whether the changed string makes a difference to the
driver.

so if the places where KBUILD_MODNAME is used doesn't actually care
about the contents of the string (and is purely for information
purposes only), then there shouldnt be a problem.  but if there is
implicit lookups/matching based on the string, then this is a problem.
-mike
