From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi/mpc52xx-spi: cleanups
Date: Fri, 20 Nov 2009 14:46:19 -0700
Message-ID: <fa686aa40911201346p4ca1c23eu1861fe1cb1e4bf26@mail.gmail.com>
References: <1258468268-9911-1-git-send-email-w.sang@pengutronix.de>
	<20091117144300.GB4850@pengutronix.de>
	<20091118095828.GA5166@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, Luotao Fu <l.fu@pengutronix.de>,
	linuxppc-dev@ozlabs.org
To: Wolfram Sang <w.sang@pengutronix.de>
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091118095828.GA5166@pengutronix.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

On Wed, Nov 18, 2009 at 2:58 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> > - =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, I=
RQF_SAMPLE_RANDOM,
>> > + =A0 =A0 =A0 =A0 =A0 rc |=3D request_irq(ms->irq1, mpc52xx_spi_irq, 0,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mpc5200-s=
pi-spiF", ms);
>>
>> The "spiF" here is probably also a typo.
>
> Ack. Grant, if you think it is worth you may modify my patch to avoid a r=
esend.
> If it is easier for you, I will do the resend, of course.

Don't resend.  Patch looks okay.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
