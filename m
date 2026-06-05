Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6C4779A3;
	Fri,  5 Jun 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644386; cv=none; b=qXRa6nksUZgd1nGXF5g/es0qc6IzGbL1GxAygPRAtn+MiCGQhcQK86pInQnp/67cH9Zbd/XQ4lCSJOe9AJ0JqnWA+O7S0Ak3qQq4jbshM42lGro1Ii39c8oyqNgx8R5lDuNv/+zOsyUv2ZOF7ZQBH237NaNNjhFIUAamfF0NVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644386; c=relaxed/simple;
	bh=Blfq6eemSgWS0AMSuwnG+29kqyOXvU+JSSagUSUo0YA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gwshvkqo2Zh515K6fOrDAKMMSTGOd4TXGHYhoTK5yFQVr/O/XnGtKuz9Xu9/Z0WZ5UcLsW7k3VVzg9kEntKUq3VJNLQlct4PgPYXSLE3mx+goXjrfKYCZAmCu8Y7+piFQoPD5rHxFunHsBgB26uDe3xHzosys7YqVmARZgK701M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1HExFZQ7; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1HExFZQ7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC69DC5846E;
	Fri,  5 Jun 2026 07:26:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 575225FED1;
	Fri,  5 Jun 2026 07:26:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A214106A1E65;
	Fri,  5 Jun 2026 09:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780644381; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=dJs1UXUNkLhBR/S0VALc0PkMzbs22zwOjldoT+MQiOE=;
	b=1HExFZQ71mYhu9loC8vT9RuOdU20EdrN8UjyVoOTSvyDNV0zdifjoy/HtaTQyrefq/5Arf
	34MwRdSYY4s2W9yEviPjziQyYRjT3DqYpyQgoNPSF28Hd7EXzr17OCWdNlXWXqdrwpy8Kp
	XJv40cpGmgtEmbfe3xkZPsklXTAZHo6BmR/sJHisgg/WaL8IjT2v5i0eJA2jpLHE9xAmHq
	JujoPbzRynWgqH61lZ7FStVew0vxVV7a4om6JdkI+DLjMOfAR6aHFSNeJ/J2sFuKllFsyW
	b/JYDCDCCP2vpn9BBQnu3thwMxcC0PwCniHNtSu2YPt5Cl92fEbWvkw+iDPf4A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>,  Santhosh Kumar K <s-k6@ti.com>,
  <broonie@kernel.org>,  <robh@kernel.org>,  <krzk+dt@kernel.org>,
  <conor+dt@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,
  <takahiro.kuwano@infineon.com>,  <linux-spi@vger.kernel.org>,
  <devicetree@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mtd@lists.infradead.org>,  <praneeth@ti.com>,  <u-kumar1@ti.com>,
  <a-dutta@ti.com>
Subject: Re: [PATCH v3 01/13] spi: dt-bindings: allow spi-max-frequency to
 specify a frequency pair
In-Reply-To: <20260605-regulate-crawling-253c6d6bd971@wendy> (Conor Dooley's
	message of "Fri, 5 Jun 2026 08:17:18 +0100")
References: <eaa75113-2b89-468d-aca8-932bc7e33a7d@ti.com>
	<87cxy92llq.fsf@bootlin.com>
	<20260602-aptly-bunkbed-1bd3a8d63d54@spud>
	<875x3zzkji.fsf@bootlin.com> <20260603-neatly-twine-e89b923f5cb6@spud>
	<87o6hry4d4.fsf@bootlin.com>
	<20260603-balance-encounter-94f69e1577f3@spud>
	<87ik7yydyv.fsf@bootlin.com>
	<20260604-shrunk-acclaim-25368d7ad63e@spud>
	<87a4t9wl7r.fsf@bootlin.com>
	<20260605-regulate-crawling-253c6d6bd971@wendy>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 05 Jun 2026 09:26:13 +0200
Message-ID: <87tsrh4fe2.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 05/06/2026 at 08:17:18 +01, Conor Dooley <conor.dooley@microchip.com> wrote:

> On Fri, Jun 05, 2026 at 08:32:56AM +0200, Miquel Raynal wrote:
>> On 04/06/2026 at 09:36:49 +01, Conor Dooley <conor@kernel.org> wrote:
>> 
>> > On Thu, Jun 04, 2026 at 09:14:16AM +0200, Miquel Raynal wrote:
>> >> Hi Conor,
>> >> 
>> >> >> >> > Right, and this I guess is what scuppers letting the controller driver
>> >> >> >> > sort the configuration out itself and leaving the property as-is.
>> >> >> >> > It could be that the speed in spi-max-frequency is lower than the "base
>> >> >> >> > speed" of the controller but because of board routing or device
>> >> >> >> > capability that the tuned mode is still required, right?
>> >> >> >> 
>> >> >> >> I do not actually expect any tuned mode/frequency to be mandatory.
>> >> >> >
>> >> >> > I think you misunderstood my use of "required", I meant that the new
>> >> >> > property/information was needed in the scenario I described, not that it
>> >> >> > should be a required property in a binding.
>> >> >> 
>> >> >> Yes I misunderstood the term indeed. However I still fail to catch what
>> >> >> you meant here, I'm sorry. Would you mind rephrasing?
>> >> >
>> >> > I was talking about a scenario where you want to use the tuned mode to
>> >> > achieve the maximum rate because of the device and/or board configuration,
>> >> > but the rate is below the point where the controller would need tuning.
>> >> > Say the controller needs tuning above 8 Hz but the conditions require
>> >> > tuning to achieve more than 5 Hz. In this example, if the device can do
>> >> > 6 Hz, spi-max-frequency (in the current form) would be set to 6 Hz, and
>> >> > the controller would not enable the tuned mode, leading to problems
>> >> > because the inflection point determined from the controller compatible
>> >> > of 8 Hz would not have been reached.
>> >> 
>> >> I don't think this is a real situation. If the "conditions", as you say
>> >> (ie. PCB routing, mostly) require tuning above 5, then spi-max-frequency
>> >> should be 5.
>> >
>> > Then tuning mode would never be used.
>> 
>> Well, this is exactly what we propose in this series, a way to indicate
>> two maximum frequencies, one that just works (like before) and a higher
>> frequency that is only reachable after an extra tuning procedure.
>> 
>> > Remember, this is a theoretical world
>> > where spi-max-frequency would contain the tuned frequency and the
>> > controller was using compatible-specific speed thresholds to determine
>> > if tuning was required.
>> 
>> That is not what we are proposing. I don't think indicating the "after
>> tuning" frequency in a property that has long been used for an always
>> reachable frequency is wise. Hence either the use of an array (the
>> second entry could contain a higher frequency) or a secondary
>> spi-max-frequency-whatever property.
>
> I am/was trying to come up with a scenario that would justify the patch
> man, stop trying to interpret it as what I want done.

Ah :-) Sorry the intention was unclear to me. So what is your preferred
take in the end?
