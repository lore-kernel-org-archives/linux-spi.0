From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Date: Tue, 14 Aug 2018 14:27:20 -0600
Message-ID: <20180814202720.GB26606@rob-hp-laptop>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
 <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk>
 <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk>
 <1533754621.2283.270.camel@impinj.com>
 <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Trent Piepho <tpiepho@impinj.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "lanqing.liu@spreadtrum.com" <lanqing.liu@spreadtrum.com>
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuKwfBB8-8o5s8FQadFSFiD8KU=qNZYQjCWOfc-QpuVRSw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 09, 2018 at 11:03:11AM +0800, Baolin Wang wrote:
> Hi Trent,
> 
> On 9 August 2018 at 02:57, Trent Piepho <tpiepho@impinj.com> wrote:
> > On Wed, 2018-08-08 at 11:54 +0100, Mark Brown wrote:
> >> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
> >> > On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
> >> > > Right, I don't think we added this yet (if we did I can't see
> >> > > it).  I'd
> >> > > add a new field to spi_transfer for this, then other controllers
> >> > > with
> >> > > the same support can implement it as well and drivers can start
> >> > > using
> >> > > it too.
> >> > OK. So I will name the new filed as 'word_delay', is it OK for you?
> >>
> >> Sounds good, yes.
> >
> > Should it be in µs like the existing iter-transfer delay?  I think
> > perhaps units of cycles of the SPI clock make more sense?
> 
> Since some SPI controllers just want some interval values (neither µs
> unit nor cycles unit ) set into hardware, and the hardware will
> convert to the correct delay time automatically. So I did not force
> 'word_delay' unit as µs or cycle, and just let the slave devices
> decide the unit which depends on the SPI hardware requirement.

This needs to be defined units in DT, not decided by each controller.

The controller capabilities just affect what are valid values (or what 
the resolution is).

Rob
