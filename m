From: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add ability to validate xfer->bits_per_word in
	SPI core
Date: Tue, 2 Apr 2013 03:12:40 -0700
Message-ID: <CA+7tXihMJX1nD=MYPDxSxE5vCw27hbANKif7Y5ESKzaM6jx8rw@mail.gmail.com>
References: <1364351878-26089-1-git-send-email-swarren@wwwdotorg.org>
	<CA+7tXihDmXtUv7Gdu_zPEcWxVHQbZS=W8RjFhOThGo0bpAMDxQ@mail.gmail.com>
	<515A443B.9080808@wwwdotorg.org>
	<CA+7tXiheFL-n8Qv1XqgdniO2rMjZYeXqwDm-3D42XpXk3ik6_w@mail.gmail.com>
	<20130402094544.GE23065@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130402094544.GE23065-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 2, 2013 at 2:45 AM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>
> I think if we're getting down to looking at the disassembly we're
> perhaps overoptimising - in the common case we're then going to start
> the hardware doing a data transfer which will take rather more time than
> these instructions.

My point was really that the smaller and simpler C code also produced
better compiled code too, so why use the more complex code?

------------------------------------------------------------------------------
Own the Future-Intel(R) Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest. Compete 
for recognition, cash, and the chance to get your game on Steam. 
$5K grand prize plus 10 genre and skill prizes. Submit your demo 
by 6/6/13. http://altfarm.mediaplex.com/ad/ck/12124-176961-30367-2
