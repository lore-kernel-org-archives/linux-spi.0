From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 6/7] mtd: m25p80: add a read function to read page by
	page
Date: Thu, 30 Sep 2010 23:41:40 +0900
Message-ID: <AANLkTi=GydTyhf3TOzCZOtrme1Jh0UmNDHqTVP59q=LH@mail.gmail.com>
References: <841976.76219.qm@web180306.mail.gq1.yahoo.com>
	<AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.hu@freescale.com>,
	linux-mtd@lists.infradead.org, kumar.gala@freescale.com,
	spi-devel-general@lists.sourceforge.net
To: David Brownell <david-b@pacbell.net>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <AANLkTinBDdEyMDt3KoauNdmTCz1ZAJ5mZ23iMWiwsUm4@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 30, 2010 at 11:16 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> On Thu, Sep 30, 2010 at 7:46 PM, David Brownell <david-b@pacbell.net> wro=
te:
>>
>> --- On Thu, 9/30/10, Mingkai Hu <Mingkai.hu@freescale.com> wrote:
>>
>>> From: Mingkai Hu <Mingkai.hu@freescale.com>
>>> Subject: [PATCH v3 6/7] mtd: m25p80: add a read function to read page b=
y page
>>
>> NAK.
>>
>> We went over this before.
>
> Yes, I agree with David on this. =A0If large transfers don't work, then
> it is the SPI master driver that is buggy.

By the way, does this fix your problem?

https://patchwork.kernel.org/patch/184752/

g.
