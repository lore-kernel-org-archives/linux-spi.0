From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] spi: dt-bindings: spi-controller: add wakeup-source
 and interrupts
Date: Fri, 15 Nov 2019 13:43:23 -0600
Message-ID: <CAL_Jsq+9eejCg41poj--GDtUqOgSUoNMpB=OEAuKhNu1Ggb7Ew@mail.gmail.com>
References: <20191112055412.192675-1-dmitry.torokhov@gmail.com>
 <20191112055412.192675-2-dmitry.torokhov@gmail.com> <20191112120307.GB5195@sirena.co.uk>
 <20191112190328.GA199853@dtor-ws> <20191112191547.GK5195@sirena.co.uk>
 <20191112193653.GB13374@dtor-ws> <20191114222652.GA7517@bogus>
 <CAKdAkRQBrKOUTW8puakA26ODYW9=0H4VhwFhGQAqMs-cMmj3CQ@mail.gmail.com>
 <CAL_JsqKUXPTC-fmUowpaHQpuKTfgfQ6D2n7kOZgkYt+MS7OfaA@mail.gmail.com> <20191115152221.GA4210@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191115152221.GA4210@sirena.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Nov 15, 2019 at 9:22 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Nov 15, 2019 at 07:52:22AM -0600, Rob Herring wrote:
>
> > if:
> >   properties:
> >     interrupt-names:
> >       contains:
> >         const: wakeup
> >   required:
> >     - interrupt-names
> > then:
> >   required:
> >     - wakeup-source
>
> That seems to say that if we have a device that has an interrupt called
> "wakeup" then it must be a wakeup source.  Is that desirable?  Being
> able to wake the system is partly a property of the system as a whole
> (the wakeup signal needs to be wired somewhere where it can wake things)
> and a device might have a signal that could be used to wake the system,
> may even be called "wakeup" by the device but for some reason isn't
> wired suitably in a given system.

Perhaps it is too strict. It would be useful as a "Did you forget
wakeup-source?" message, but we don't have a way to distinguish that.

Rob
