From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] spi: reorganize drivers
Date: Mon, 6 Jun 2011 10:52:46 -0600
Message-ID: <BANLkTi=s2pnANPS5ZhjM9ZW8Bctk2v3DLw@mail.gmail.com>
References: <20110606071829.10334.90865.stgit@ponder> <BANLkTinqVf+uK+5T_X-EkXw-YE67DJL1Pg@mail.gmail.com>
 <BANLkTinmfufSkSnmiKWWEgpaR-usbiV5tA@mail.gmail.com> <4DED0510.1030600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Frysinger <vapier.adi@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DED0510.1030600@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jun 6, 2011 at 10:49 AM, Dirk Brandewie
<dirk.brandewie@gmail.com> wrote:
> On 06/06/2011 09:38 AM, Grant Likely wrote:
>>
>> On Mon, Jun 6, 2011 at 10:31 AM, Mike Frysinger<vapier.adi@gmail.com=
>
>> =A0wrote:
>>>
>>> On Mon, Jun 6, 2011 at 03:18, Grant Likely wrote:
>>>>
>>>> Sort the SPI makefile and enforce the naming convention spi_*.c fo=
r
>>>> spi drivers.
>>>
>>> spi_topcliff_pch.c uses KBUILD_MODNAME with a few funcs, but perhap=
s
>>> those are only for /proc/ status tracking ? =A0worth double checkin=
g ...
>>
>> I just talked with Dirk Brandewie, who has a major rewrite to the
>> topcliff spi driver. =A0I'll let him comment on whether or not chang=
ing
>> KBUILD_MODNAME will cause any problems.
>>
>
> My changes are to the designware driver :-) I will get my patches re-=
based
> onto the spi-next branch and see if there any issues.

Hahaha.  Oops, I can't remember the conversation I had 5 minutes after
getting off the phone.

It should actually be Tomoya who can comment on the name change.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
