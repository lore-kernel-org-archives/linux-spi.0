From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
Date: Wed, 19 May 2010 22:56:35 -0600
Message-ID: <AANLkTinU7CunVOcgAksLhKrzJKOEGORMVHPemS52ZrgD@mail.gmail.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
	<20100417110036.GC19534@gw.healthdatacare.com>
	<q2pfa686aa41004191102qc93f09b6m941785b4cb4e32db@mail.gmail.com>
	<y2q56d259a01004191216o48763eafy6401779ddae0f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net,
	Mika Westerberg <mika.westerberg@iki.fi>,
	linux-arm-kernel@lists.infradead.org
To: Martin Guy <martinwguy@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <y2q56d259a01004191216o48763eafy6401779ddae0f1@mail.gmail.com>
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

On Mon, Apr 19, 2010 at 1:16 PM, Martin Guy <martinwguy@gmail.com> wrote:
> On 4/19/10, Grant Likely <grant.likely@secretlab.ca> wrote:
>> =A0>> > + =A0 =A0 =A0 /* read all received data */
>> =A0>> > + =A0 =A0 =A0 while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RN=
E) &&
>> =A0>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->rx < t->len) {
>> =A0>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_do_read(espi, t);
>> =A0>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->fifo_level--;
>> =A0>> > + =A0 =A0 =A0 }
>> =A0>>
>> =A0>> Another busywait loop. =A0Could end up burning an awful lot of cyc=
les
>> =A0>> here. =A0A state machine might be more suitable for this driver so=
 that
>> =A0>> processing can be punted to deferred work when the FIFO gets either
>> =A0>> empty or full.
>> =A0>
>> =A0> FIFO size is max 8 frames so there should be 8 iterations when the
>> =A0> FIFO is full. So is it enought to to add check that we only read
>> =A0> max 8 frames from the FIFO?
>>
>> =A0If you do it right, FIFO size shouldn't matter. =A0The driver should
>> =A0easily be able to read however many are available and defer until more
>> =A0is ready.
>
> Sorry, I completely missed the point at the end of the last post.
>
> This is not a busywait loop. It takes bytes out of the RX FIFO until
> it is empty, which is all useful work. There is also no way to tell
> just from our internal variables how many bytes are in the RX FIFO as
> far as I know, so the only way is to check the Receiver-Not-Empty
> status bit (which is what this code does).

Yeah, you're right.  I was scanning through the code too quickly and
jumped to conclusions without actually checking.  Sorry about the
noise.

g.
