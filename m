From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Thu, 26 Nov 2009 11:50:05 -0700
Message-ID: <fa686aa40911261050g3f7ae231mc82c41f058ff8530@mail.gmail.com>
References: <200911161742.46663.to-fleischer@t-online.de>
	<200911211708.47253.to-fleischer@t-online.de>
	<fa686aa40911241633q38dc0cf8x8b23038fe2fdf10d@mail.gmail.com>
	<200911252141.59549.to-fleischer@t-online.de>
	<fa686aa40911251411t13dd0131od6b497399641ce3d@mail.gmail.com>
	<20091126121204.GA3558@oksana.dev.rtsoft.ru>
	<fa686aa40911261016p489981a2g1fac393264c4d1c7@mail.gmail.com>
	<20091126184157.GA16607@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Torsten Fleischer <to-fleischer@t-online.de>,
	spi-devel-general@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org
To: avorontsov@ru.mvista.com
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20091126184157.GA16607@oksana.dev.rtsoft.ru>
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

On Thu, Nov 26, 2009 at 11:41 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Thu, Nov 26, 2009 at 11:16:34AM -0700, Grant Likely wrote:
> [...]
>> The spi-cs-high property is defined in
>> Documentation/powerpc/dts-bindings/spi-bus.txt, but it definitely was
>> a mistake
>
> Yup.
>
>> Currently the spi-cs-high property is parsed in the
>> of_register_spi_devices() function, but the CS polarity needs to be
>> known before registering devices. =A0It needs to be factored out into
>> another utility function callable by spi bus drivers so that it can
>> get polarity data at probe time.
>
> Untill we have this, Torsten's patch is a real improvement, and
> works for non-broken hw/fw.
>
> So I think it should be applied.

I disagree since it only band-aids the problem and uglifies the driver
in the process.  In the immediate term the driver needs to be changed
to read the spi-cs-high property out of the child nodes before
registering the devices.  I'm not going to apply this patch.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
