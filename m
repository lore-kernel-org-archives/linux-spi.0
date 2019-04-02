From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Date: Tue, 2 Apr 2019 08:43:51 +0000
Message-ID: <ce9e8ca8-6db7-1be8-5ea3-c098b1c1c813@prevas.dk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
 <20190401073450.GG2059@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401073450.GG2059@sirena.org.uk>
Content-Language: en-US
Content-ID: <F259E65989CB92429186EC3522A6D6EC@EURPRD10.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/04/2019 09.34, Mark Brown wrote:
> On Wed, Mar 27, 2019 at 02:30:48PM +0000, Rasmus Villemoes wrote:
>> I doubt patches 3 and 4 are acceptable, but I'd still like to get
>> comments and/or alternative suggestions for making large transfers
>> faster.
>=20
> I see no problem with this from a framework point of view FWIW, it's
> going to be a question of if there's any glitches like you say.  I'm not
> sure how we can get wider testing/review unless the patches actually get
> merged though...  I'll leave them for a bit longer but unless someone
> sees a problem I'll probably go ahead and apply them.
>=20

Thanks! There's one other option I can think of: don't do the interrupts
at all, but just busy-wait for the completion of each word transfer (in
a cpu_relax() loop). That could be guarded by something like
1000000*bits_per_word < hz (roughly, the word transfer takes less than 1
us). At least on -rt, having the interrupt thread scheduled in and out
again easily takes more than 1us of cpu time, and AFAIU we'd still be
preemptible throughout - and/or one can throw in a cond_resched() every
nnn words. But this might be a bit -rt specific, and the 1us threshold
is rather arbitrary.

Rasmus
