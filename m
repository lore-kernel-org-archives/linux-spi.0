From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 17:37:53 +0200
Message-ID: <CAOMqctSfDKJRYf7bY7pz7LE9obUxMvV-v=Ntz3_mk0WGMKbPtA@mail.gmail.com>
References: <20160628155107.GP17217@sirena.org.uk> <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk> <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk> <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk> <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <20160701082548.GE6247@sirena.org.uk> <CAOMqctRp+ua1DM82W35Df17TvhoF2suxALBaYqECWtTRrTWXCw@mail.gmail.com>
 <20160701150015.GQ6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160701150015.GQ6247@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1 July 2016 at 17:00, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Jul 01, 2016 at 10:58:34AM +0200, Michal Suchanek wrote:
>> On 1 July 2016 at 10:25, Mark Brown <broonie@kernel.org> wrote:
>
>> > It's been repeatedly suggested to you that the tooling for this stuff
>> > could use some work.  Please go and put some effort into that rather
>> > than continuing this thread which is accomplishing nothing.
>
>> You completely miss the point. No tooling will make people reconfigure
>> the kernel when the configuration in fact stays the same.
>
>> Sure the tooling does need work. And it would help getting the cases
>> when the tooling is NOT needed out of the way.
>
> I understand the problem perfectly, no amount of repeating yourself is
> going to change the problems that the bodge you are trying to force in
> creates for other users and the maintainability of the system.

Can you, please, specify what problems this patch creates for other users
and maintainability?

Without stating the problems of this solution clearly or proposing alternate
workable solution there is not much that can be done.

Thanks

Michal
