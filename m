From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/5] remove spi-s3c24xx-gpio driver
Date: Wed, 29 Jun 2011 11:17:51 -0600
Message-ID: <BANLkTi=693aHH=8BTAyrKWc1padiozpT6A@mail.gmail.com>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
	<20110628212443.GI21138@trinity.fluff.org>
	<87ipro4loa.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net, ben-linux@fluff.org,
	Ben Dooks <ben@trinity.fluff.org>
To: Peter Korsgaard <jacmet@sunsite.dk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <87ipro4loa.fsf@macbook.be.48ers.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 29, 2011 at 11:00 AM, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>>>>> "Ben" =3D=3D Ben Dooks <ben@trinity.fluff.org> writes:
>
> =A0>> The spi-s3c24xx-gpio driver is functionally equivalent to the spi-g=
pio
> =A0>> driver (but precedes it). The driver has seen very little developme=
nt
> =A0>> since it got added back in 2006, and there's only 2 in-tree users o=
f it.
> =A0>>
> =A0>> This patch series moves the remaining users to the spi-gpio driver =
and
> =A0>> then finally removes the driver.
> =A0>>
> =A0>> Compile tested only as I don't have access to the hardware.
>
> =A0Ben> I've not really got much in the way of access either, however the
> =A0Ben> series looks sane to me.
>
> =A0Ben> Acked-by: Ben Dooks <ben-linux@fluff.org>
>
> Great, will you handle the series or should it go through the spi tree?

With the big spi driver rename, it should probably either go via the
spi tree, or be put into a topic branch that can be merged by both the
spi and samsung trees.

g.
